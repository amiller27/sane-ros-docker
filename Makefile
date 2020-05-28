all: melodic-18.04-image kinetic-16.04-image indigo-14.04-image

%-image:
	$(eval distro := $(word 1,$(subst -, ,$*)))
	$(eval os_version := $(word 2,$(subst -, ,$*)))
	docker pull osrf/ros:${distro}-desktop-full
	m4 -D M4_OS_VERSION=${os_version} Dockerfile.m4 > Dockerfile.${os_version}.generated
	docker build -t sane-${distro} \
		--build-arg USER \
		--build-arg ROS_DISTRO=${distro} \
		--build-arg OS_VERSION=${os_version} \
		-f Dockerfile.${os_version}.generated .
