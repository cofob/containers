FROM mcr.microsoft.com/devcontainers/base:debian-12

RUN sudo curl -LsSf https://astral.sh/uv/install.sh | sh && \
    sudo apt-get update && \
    sudo apt-get install --no-install-recommends curl qemu-kvm libvirt-daemon-system bridge-utils virtinst libvirt-daemon -y
