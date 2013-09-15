# Inherit common PAP stuff
$(call inherit-product, vendor/pap/config/common.mk)


# Optional AX packages
PRODUCT_PACKAGES += \
    HoloSpiralWallpaper \
    MagicSmokeWallpapers \
    NoiseField \
    Galaxy4 \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    PhaseBeam \
    ShareLogs
