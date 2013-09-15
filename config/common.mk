PRODUCT_BRAND ?= aosp

ifdef pap_NIGHTLY
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

PRODUCT_PACKAGE_OVERLAYS += vendor/pap/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/pap/overlay/common

PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 0
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
        # Add leading dash to PAP_EXTRAVERSION
        PAP_EXTRAVERSION := -$(PAP_EXTRAVERSION)
    endif
else
    # If pap_BUILDTYPE is not defined, set to UNOFFICIAL
    PAP_BUILDTYPE := UNOFFICIAL
    PAP_EXTRAVERSION :=
endif

ifdef PAP_RELEASE
    PAP_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(PAP_BUILD)
else
    ifeq ($(PRODUCT_VERSION_MINOR),0)
        PAP_VERSION := $(PRODUCT_VERSION_MAJOR)-$(shell date -u +%Y%m%d)-$(PAP_BUILDTYPE)-$(pap_BUILD)$PAP_EXTRAVERSION)
    else
        PAP_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date -u +%Y%m%d)-$(PAP_BUILDTYPE)-$(PAP_BUILD)$(PAP_EXTRAVERSION)
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.pap.version=$(PAP_VERSION) \
  ro.modversion=pap-$(PAP_VERSION) \
  ro.goo.developerid=Lloir \
  ro.goo.rom=PureAosp \
  ro.goo.version=$(shell date +%s)


-include $(WORKSPACE)/hudson/image-auto-bits.mk
