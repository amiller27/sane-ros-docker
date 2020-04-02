all: melodic-image kinetic-image indigo-image

%-image:
	docker pull osrf/ros:$*-desktop-full
	docker build -t sane-$* --build-arg USER --build-arg ROS_DISTRO=$* .
