# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/CAF-Extended/manifest.git -b 11.0 -g default,-device,-mips,-darwin,-notdefault
git clone https://github.com/wHo-EM-i/manifest.git --depth 1 -b cafex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

source build/envsetup.sh
lunch cafex_lavender-userdebug
export SELINUX_IGNORE_NEVERALLOWS=true
export TZ=Asia/Kolkata #put before last build command
export KBUILD_BUILD_USER=wHoEMi
export KBUILD_BUILD_HOST=ehtesham
m cafex

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
