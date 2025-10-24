#
# Helper class that collects all artifacts referenced by IMAGE_BOOT_FILES
# and bundles them into a compressed archive.  Useful for delivering
# Raspberry Pi / Boot2Qt boot partitions alongside SWUpdate payloads.
#

BOOTPARTITION_ARCHIVE_SUFFIX ?= ".boot.tar.zst"
BOOTPARTITION_ARCHIVE_IMAGE_NAME ?= "${IMAGE_NAME}"
BOOTPARTITION_ARCHIVE_LINK_NAME ?= "${IMAGE_LINK_NAME}"
BOOTPARTITION_ARCHIVE_FILENAME ?= "${BOOTPARTITION_ARCHIVE_IMAGE_NAME}${BOOTPARTITION_ARCHIVE_SUFFIX}"
BOOTPARTITION_ARCHIVE_OUTPUT ?= "${DEPLOY_DIR_IMAGE}/${BOOTPARTITION_ARCHIVE_FILENAME}"
BOOTPARTITION_ARCHIVE_STAGING_DIR ?= "${WORKDIR}/bootpartition-staging"

BOOTPARTITION_ARCHIVE_EXTRA_DEPENDS ?= ""

do_bootpartition_archive[cleandirs] += "${BOOTPARTITION_ARCHIVE_STAGING_DIR}"
do_bootpartition_archive[dirs] = "${BOOTPARTITION_ARCHIVE_STAGING_DIR}"
do_bootpartition_archive[depends] += " \
    virtual/kernel:do_deploy \
    zstd-native:do_populate_sysroot \
    rpi-bootfiles:do_deploy \
    ${@bb.utils.contains('RPI_USE_U_BOOT', '1', ' u-boot:do_deploy u-boot-default-script:do_deploy', '', d)} \
    ${@bb.utils.contains('MACHINE_FEATURES', 'armstub', ' armstubs:do_deploy', '', d)} \
    ${BOOTPARTITION_ARCHIVE_EXTRA_DEPENDS} \
"

python do_bootpartition_archive() {
    import os
    import re
    import shutil
    import subprocess
    from glob import glob
    from pathlib import Path

    deploy_dir = Path(d.getVar("DEPLOY_DIR_IMAGE"))
    stage_dir = Path(d.getVar("BOOTPARTITION_ARCHIVE_STAGING_DIR"))
    stage_dir.mkdir(parents=True, exist_ok=True)

    boot_files = d.getVar("IMAGE_BOOT_FILES")
    if not boot_files:
        bb.fatal("IMAGE_BOOT_FILES is empty; cannot assemble boot archive.")

    install_tasks = []
    pattern = re.compile(r'[\w;\-\./\*]+')
    for src_entry in pattern.findall(boot_files):
        if ';' in src_entry:
            src, dst = src_entry.split(';', 1)
            if not src or not dst:
                bb.fatal(f"Malformed boot file entry '{src_entry}'")
        else:
            src = dst = src_entry

        if '*' in src:
            entry_name_fn = os.path.basename
            if dst != src:
                entry_name_fn = lambda name, dest=dst: os.path.join(dest, os.path.basename(name))

            matches = glob(str(deploy_dir / src))
            if not matches:
                bb.fatal(f"Pattern '{src}' matched no files under {deploy_dir}")
            for match in matches:
                rel_src = os.path.relpath(match, deploy_dir)
                install_tasks.append((rel_src, entry_name_fn(match)))
        else:
            install_tasks.append((src, dst))

    if not install_tasks:
        bb.fatal("No boot files resolved from IMAGE_BOOT_FILES; aborting.")

    for src_rel, dst_rel in install_tasks:
        src_path = deploy_dir / src_rel
        if not src_path.exists():
            bb.fatal(f"Boot file '{src_path}' not found.")
        dest_path = stage_dir / dst_rel
        dest_path.parent.mkdir(parents=True, exist_ok=True)
        if src_path.is_symlink():
            target_path = src_path.resolve(strict=False)
            if not target_path.exists():
                bb.fatal(f"Boot file symlink '{src_path}' points to missing target '{target_path}'.")
            shutil.copy2(target_path, dest_path, follow_symlinks=True)
        elif src_path.is_dir():
            shutil.copytree(src_path, dest_path, symlinks=False, dirs_exist_ok=True)
        else:
            shutil.copy2(src_path, dest_path, follow_symlinks=True)

    output_path = Path(d.getVar("BOOTPARTITION_ARCHIVE_OUTPUT"))
    output_path.parent.mkdir(parents=True, exist_ok=True)
    if output_path.exists():
        output_path.unlink()

    tar_cmd = [
        "tar",
        "--sort=name",
        "--mtime=@0",
        "--owner=0",
        "--group=0",
        "--numeric-owner",
        "--format=gnu",
        "-C",
        str(stage_dir),
        "-cf",
        "-",
        ".",
    ]
    zstd_cmd = ["zstd", "-T0", "-19", "-q", "-o", str(output_path)]

    tar_proc = subprocess.Popen(tar_cmd, stdout=subprocess.PIPE)
    try:
        zstd_proc = subprocess.Popen(zstd_cmd, stdin=tar_proc.stdout)
        tar_proc.stdout.close()
        zstd_rc = zstd_proc.wait()
        tar_rc = tar_proc.wait()
    finally:
        if tar_proc.stdout:
            tar_proc.stdout.close()

    if tar_rc != 0:
        bb.fatal(f"tar command failed while creating boot archive (exit code {tar_rc}).")
    if zstd_rc != 0:
        bb.fatal(f"zstd command failed while compressing boot archive (exit code {zstd_rc}).")

    link_name = d.getVar("BOOTPARTITION_ARCHIVE_LINK_NAME")
    if link_name:
        link_path = Path(d.getVar("DEPLOY_DIR_IMAGE")) / f"{link_name}{d.getVar('BOOTPARTITION_ARCHIVE_SUFFIX')}"
        if link_path.exists() or link_path.is_symlink():
            link_path.unlink()
        link_target = os.path.relpath(output_path, link_path.parent)
        os.symlink(link_target, link_path)

    bb.note(f"Created boot partition archive at {output_path}")
}

addtask bootpartition_archive after do_image_complete before do_build
