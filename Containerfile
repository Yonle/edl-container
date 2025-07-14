FROM docker.io/alpine:3.22

RUN apk add --no-cache \
    android-tools libusb py3-pip python3 git xz cmake build-base

RUN git clone \
          --depth=1 \
          --branch=master \
          --recurse-submodules \
          --shallow-submodules \
          https://github.com/bkerler/edl /root/edl

WORKDIR /root/edl

RUN pip3 install --root-user-action ignore --break-system-packages -r requirements.txt
RUN python3 setup.py build
RUN python3 setup.py install

# Cleanups

RUN pip3 cache purge
RUN find /usr/local -type f -name '*.pyc' -delete
RUN apk del build-base cmake
