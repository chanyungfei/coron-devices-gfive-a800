#!/bin/bash

apkBaseName=$1
tempSmaliDir=$2

if [ "$apkBaseName" = "Phone" ];then
    echo ">>> in custom_app $apkBaseName"
    echo ">>> use Lcom/mediatek/notification/NotificationPlus instead of Landroid/app/NotificationPlus in Phone"
    echo ">>> use Lcom/mediatek/notification/NotificationManagerPlus instead of Landroid/app/NotificationManagerPlus in Phone"
    sed -i 's/Landroid\/app\/NotificationPlus/Lcom\/mediatek\/notification\/NotificationPlus/g' $tempSmaliDir/smali/com/android/phone/NotificationMgr.smali
    sed -i 's/Landroid\/app\/NotificationManagerPlus/Lcom\/mediatek\/notification\/NotificationManagerPlus/g' $tempSmaliDir/smali/com/android/phone/NotificationMgr.smali

elif [ "$apkBaseName" = "Settings" ];then
    echo ">>> in custom_app $apkBaseName"
# Remove the Official Verify Preference.
	sed -i -e "/^\.method.*setOfficialVerifyPreference()V/,/^\.end method/d" $tempSmaliDir/smali/com/android/settings/DeviceInfoSettings.smali
	sed -i -e "/setOfficialVerifyPreference/d" $tempSmaliDir/smali/com/android/settings/DeviceInfoSettings.smali	

    echo ">>> use isHaveExternalSdcard to check weather support UsbMassStorage in UsbSettings.java"
    sed -i 's#invoke-virtual {v.*}, Landroid/os/storage/StorageVolume;->allowMassStorage()Z#invoke-direct {p0}, Lcom/android/settings/deviceinfo/UsbSettings;->isHaveExternalSdcard()Z#g' $tempSmaliDir/smali/com/android/settings/deviceinfo/UsbSettings.smali
fi

