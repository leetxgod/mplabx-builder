FROM ubuntu:noble

ARG DFP="SAMV71_DFP"
ARG RT_DFP="SAMV71-RT_DFP"

ARG MPLAB_VERSION
ARG MPLAB_DOWNLOAD

ARG XC32_DOWNLOAD
ARG XC32_VERSION

ARG CMSIS_DOWNLOAD
ARG CMSIS_VERSION

ARG DFP_DOWNLOAD
ARG DFP_VERSION

ARG RT_DFP_DOWNLOAD
ARG RT_DFP_VERSION

ENV USER_AGENT="Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0"

RUN apt-get update && \
  apt-get install -y --no-install-recommends apt-utils && \
  dpkg --add-architecture i386 \
  && apt-get update -yq \
  && apt-get install -yq --no-install-recommends ca-certificates wget unzip libc6:i386 git \
  libx11-6:i386 libxext6:i386 libstdc++6:i386 libexpat1:i386 \
  libxext6 libxrender1 libxtst6 libgtk2.0-0 make libusb-1.0-0-dev \
  && rm -rf /var/lib/apt/lists/*

RUN wget -q --user-agent="${USER_AGENT}" \
 "${MPLAB_DOWNLOAD}" --https-only --show-progress --progress=bar:force:noscroll \
 -O MPLABX-${MPLAB_VERSION}-linux-installer.tar

RUN  tar xf MPLABX-${MPLAB_VERSION}-linux-installer.tar && rm -f MPLABX-${MPLAB_VERSION}-linux-installer.tar \
 && USER=root ./*-installer.sh --nox11 \
 -- --unattendedmodeui none --mode unattended 

RUN rm -f MPLABX-v${MPLAB_VERSION}-linux-installer.sh && \
 cd /opt/microchip/mplabx/v${MPLAB_VERSION}/ && \
 rm -rf docs && \
 rm Uninstall_MPLAB_X_IDE_v${MPLAB_VERSION} && \
 rm Uninstall_MPLAB_X_IDE_v${MPLAB_VERSION}.desktop && \
 rm -f Uninstall_MPLAB_X_IDE_*.dat && \
 cd mplab_platform && rm  -rf mplab_ipe && \
 cd ../packs && rm -rf arm && \
 rm -rf Microchip && \
 mkdir Microchip

RUN wget -q --user-agent="${USER_AGENT}" "${DFP_DOWNLOAD}" \
 && mkdir -p /opt/microchip/mplabx/v${MPLAB_VERSION}/packs/Microchip/${DFP}/ \
 && USER=root unzip -o Microchip.${DFP}.${DFP_VERSION}.atpack -d /opt/microchip/mplabx/v${MPLAB_VERSION}/packs/Microchip/${DFP}/${DFP_VERSION} \
 && rm Microchip.${DFP}.${DFP_VERSION}.atpack

RUN wget -q --user-agent="${USER_AGENT}" "${RT_DFP_DOWNLOAD}" \
 && mkdir -p /opt/microchip/mplabx/v${MPLAB_VERSION}/packs/Microchip/${RT_DFP}/ \
 && USER=root unzip -o Microchip.${RT_DFP}.${RT_DFP_VERSION}.atpack -d /opt/microchip/mplabx/v${MPLAB_VERSION}/packs/Microchip/${RT_DFP}/${RT_DFP_VERSION} \
 && rm Microchip.${RT_DFP}.${RT_DFP_VERSION}.atpack

#RUN wget -q --user-agent="${USER_AGENT}" "${XC32_DOWNLOAD}" \
