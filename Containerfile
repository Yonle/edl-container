FROM docker.io/alpine:3.22

LABEL org.opencontainers.image.source="https://github.com/Yonle/edl-container" \
      org.opencontainers.image.description="basically a container for bkerler/edl program, because you hate waiting for it's dependencies to get compiled." \
      org.opencontainers.image.licenses="MIT"

RUN apk add --no-cache \
    android-tools libusb py3-pip python3 git xz cmake build-base

RUN git clone \
          --depth=1 \
          --branch=master \
          --recurse-submodules \
          --shallow-submodules \
          https://github.com/bkerler/edl /root/edl

WORKDIR /root/edl

RUN pip3 install --root-user-action ignore --break-system-packages -r requirements.txt \
    && python3 setup.py build \
    && python3 setup.py install \
    && mkdir -p /root/misc && mv Drivers/ install-linux-edl-drivers.sh /root/misc/ \
    && mv LICENSE /root/edlclient-LICENSE \
    && pip3 cache purge && rm -rf /root/.cache /root/edl \
    && find /usr/lib/python3.12/ -type f -name '*.pyc' -delete \
    && apk del build-base cmake
