# Inherit common PAP stuff
$(call inherit-product, vendor/pap/config/common.mk)


# Optional PAP packages
PRODUCT_PACKAGES += \
    HoloSpiralWallpaper \
    MagicSmokeWallpapers \
    NoiseField \
    Galaxy4 \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    PhaseBeam \
    busybox

# SU
PRODUCT_COPY_FILES += \
    vendor/pap/prebuilt/common/su/su:system/xbin/su \
    vendor/pap/prebuilt/common/su/su:system/xbin/daemonsu \
    vendor/pap/prebuilt/common/su/su:system/bin/.ext/.su \
    vendor/pap/prebuilt/common/su/Superuser.apk:system/app/Superuser.apk

