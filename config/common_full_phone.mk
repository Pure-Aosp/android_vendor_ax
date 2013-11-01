# Inherit common PaP stuff
$(call inherit-product, vendor/pap/config/common_full.mk)

# Default ringtone
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.ringtone=Orion.ogg \
    ro.config.notification_sound=Deneb.ogg \
    ro.config.alarm_alert=Hassium.ogg

PRODUCT_PACKAGES += \
  Mms

# Required AX packages
# PRODUCT_PACKAGES += \
#  Superuser \
#   su
