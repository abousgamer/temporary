# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/CarbonROM/android.git -b cr-9.0 -g default,-mips,-darwin,-notdefault
git clone https://github.com/youssefnone/android_manifest_samsung_m10lte.git --depth 1 -b cr-9.0 .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom1.
source build/envsetup.sh
lunch carbon_m10lte-user
export TZ=Asia/Dhaka #put before last build command
make carbon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
