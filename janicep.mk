# Include common makefile
$(call inherit-product, device/samsung/u8500-common/u8500.mk)

LOCAL_PATH := device/samsung/janicep
JANICE_PATH := device/samsung/janice

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(JANICE_PATH)/overlay

# STE
PRODUCT_COPY_FILES += \
    $(JANICE_PATH)/configs/ste_modem.sh:system/etc/ste_modem.sh

# GPS
PRODUCT_COPY_FILES += \
    $(JANICE_PATH)/configs/gps.conf:system/etc/gps.conf \
    $(JANICE_PATH)/configs/sirfgps.conf:system/etc/sirfgps.conf

# Compass workaround
PRODUCT_COPY_FILES += \
    $(JANICE_PATH)/configs/compass:system/etc/init.d/compass

$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/init.samsungjanice.rc:root/init.samsungjanice.rc \
    $(JANICE_PATH)/rootdir/device_tunables.rc:root/device_tunables.rc \
    $(JANICE_PATH)/rootdir/fstab.samsungjanice:root/fstab.samsungjanice \
    $(JANICE_PATH)/rootdir/init.recovery.samsungjanice.rc:root/init.recovery.samsungjanice.rc \
    $(JANICE_PATH)/rootdir/ueventd.samsungjanice.rc:root/ueventd.samsungjanice.rc

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml

# Audio
PRODUCT_COPY_FILES += \
    $(JANICE_PATH)/configs/adm.sqlite-u8500:system/etc/adm.sqlite-u8500

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/NFC/nfcee_access.xml:system/etc/nfcee_access.xml \
    packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml

# Use non-open-source parts if present
$(call inherit-product-if-exists, vendor/samsung/u8500/janice/janicep-vendor-blobs.mk)
