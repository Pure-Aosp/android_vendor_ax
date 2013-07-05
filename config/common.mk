PRODUCT_BRAND ?= aosp

ifdef AX_NIGHTLY
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=aospN
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=aosp+
endif

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

PRODUCT_PACKAGE_OVERLAYS += vendor/ax/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/ax/overlay/common

#SuperUserEmbedding
SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser
## IT NEEDS THIS PATCH FOR EMBEDDING INTO SETTINGS ##
## http://review.cyanogenmod.org/#/c/32957/ ##

PRODUCT_VERSION_MAJOR = 0
PRODUCT_VERSION_MINOR = 7
PRODUCT_VERSION_MAINTENANCE = BETA

# Set AX_BUILDTYPE
ifdef AX_NIGHTLY
    AX_BUILDTYPE := NIGHTLY
endif
ifdef AX_EXPERIMENTAL
    AX_BUILDTYPE := EXPERIMENTAL
endif
ifdef AX_RELEASE
    AX_BUILDTYPE := RELEASE
endif

ifdef AX_BUILDTYPE
    ifdef AX_EXTRAVERSION
        # Force build type to EXPERIMENTAL
        AX_BUILDTYPE := EXPERIMENTAL
        # Add leading dash to AX_EXTRAVERSION
        AX_EXTRAVERSION := -$(AX_EXTRAVERSION)
    endif
else
    # If AX_BUILDTYPE is not defined, set to UNOFFICIAL
    AX_BUILDTYPE := UNOFFICIAL
    AX_EXTRAVERSION :=
endif

ifdef AX_RELEASE
    AX_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(AX_BUILD)
else
    ifeq ($(PRODUCT_VERSION_MINOR),0)
        AX_VERSION := $(PRODUCT_VERSION_MAJOR)-$(shell date -u +%Y%m%d)-$(AX_BUILDTYPE)-$(AX_BUILD)$AX_EXTRAVERSION)
    else
        AX_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(AX_BUILDTYPE)-$(AX_BUILD)$(AX_EXTRAVERSION)
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.AX.version=$(AX_VERSION) \
  ro.modversion=Ax-$(AX_VERSION) \
  ro.goo.developerid=Lloir \
  ro.goo.rom=Aosp+ \
  ro.goo.version=$(shell date +%s)


-include $(WORKSPACE)/hudson/image-auto-bits.mk
