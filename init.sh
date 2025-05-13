#!/bin/bash

MPLAB_VERSION=6.20
CMSIS_VERSION=5.8.0
DFP_VERSION=4.10.230
RT_DFP_VERSION=1.2.125
XC32_VERSION=4.45

MPLAB_DOWNLOAD_EX="www.microchip.com/bin/download?f=$(echo -n "https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/MPLABX-v$MPLAB_VERSION-linux-installer.tar" | base64 -w 0)"
CMSIS_DOWNLOAD_EX="https://packs.download.microchip.com/ARM.CMSIS.$CMSIS_VERSION.atpack"
DFP_DOWNLOAD_EX="https://packs.download.microchip.com/Microchip.SAMV71_DFP.$DFP_VERSION.atpack"
RT_DFP_DOWNLOAD_EX="https://packs.download.microchip.com/Microchip.SAMV71-RT_DFP.$DFP_VERSION.atpack"
XC32_DOWNLOAD_EX="https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/xc32-v${XC32_VERSION}-full-install-linux-x64-installer.run"

echo "Building for MPLAB $MPLAB_VERSION (SAMV71_DFP $DFP_VERSION CMSIS $CMSIS_VERSION)"
docker build -f Dockerfile . \
			--build-arg MPLAB_DOWNLOAD=$MPLAB_DOWNLOAD_EX \
			--build-arg MPLAB_VERSION=$MPLAB_VERSION \
			--build-arg CMSIS_DOWNLOAD=$CMSIS_DOWNLOAD_EX \
			--build-arg CMSIS_VERSION=$CMSIS_VERSION \
			--build-arg DFP_DOWNLOAD=$DFP_DOWNLOAD_EX \
			--build-arg DFP_VERSION=$DFP_VERSION \
			--build-arg RT_DFP_DOWNLOAD=$RT_DFP_DOWNLOAD_EX \
			--build-arg RT_DFP_VERSION=$RT_DFP_VERSION \
			--build-arg XC32_DOWNLOAD=$XC32_DOWNLOAD_EX \
			--build-arg XC32_VERSION=$XC32_VERSION \
			-t mplab_builder
