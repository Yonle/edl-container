FROM docker.io/alpine:3.22

RUN apk add --no-cache \
    android-tools libusb py3-pip python3 git xz cmake build-base

RUN git clone https://github.com/bkerler/edl /root/edl 

WORKDIR /root/edl

RUN git submodule update --init --recursive
RUN pip3 install -r requirements.txt --break-system-packages --root-user-action
RUN python3 setup.py build
RUN python3 setup.py install
