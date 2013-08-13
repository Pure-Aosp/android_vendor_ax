PRODUCT_BRAND ?= aosp

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

PRODUCT_PACKAGE_OVERLAYS += vendor/pap/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/papoverlay/common

PRODUCT_VERSION_MAJOR = 0
PRODUCT_VERSION_MINOR = 2
PRODUCT_VERSION_MAINTENANCE = BETA

# Set PAP_BUILDTYPE
ifdef PAP_NIGHTLY
    PAP_BUILDTYPE := NIGHTLY
endif
ifdef PAP_EXPERIMENTAL
    PAP_BUILDTYPE := EXPERIMENTAL
endif
ifdef PAP_RELEASE
    PAP_BUILDTYPE := RELEASE
endif

ifdef PAP_BUILDTYPE
    ifdef PAP_EXTRAVERSION
        # Force build type to EXPERIMENTAL
        PAP_BUILDTYPE := EXPERIMENTAL
        # Add leading dash to AX_EXTRAVERSION
        PAP_EXTRAVERSION := -$(AX_EXTRAVERSION)
    endif

ifdef PAP_RELEASE
    PAP_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(PAP_BUILD)
else
    ifeq ($(PRODUCT_VERSION_MINOR),0)
        PAP_VERSION := $(PRODUCT_VERSION_MAJOR)-$(shell date -u +%Y%m%d)-$(PAP_BUILDTYPE)-$(PAP_BUILD)$PAP_EXTRAVERSION)
    else
        PAP_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(PAP_BUILDTYPE)-$(PAP_BUILD)$(PAP_EXTRAVERSION)
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.PAP.version=$(PAP_VERSION) \
  ro.modversion=pap-$(PAP_VERSION) \
  ro.goo.developerid=Lloir \
  ro.goo.rom=PureAosp \
  ro.goo.version=$(shell date +%s)


-include $(WORKSPACE)/hudson/image-auto-bits.mk

endif