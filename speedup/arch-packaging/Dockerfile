FROM archlinux
RUN pacman -Syu --noconfirm && \
	pacman -S --noconfirm base-devel git dpkg pacman-contrib wget curl sudo && \
	useradd -m -G wheel -s /bin/bash arch && \
	echo "arch ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER arch
