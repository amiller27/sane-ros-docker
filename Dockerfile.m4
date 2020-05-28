ARG OS_VERSION
ARG ROS_DISTRO
FROM nvidia/opengl:1.0-glvnd-runtime-ubuntu${OS_VERSION} as opengl

FROM osrf/ros:$ROS_DISTRO-desktop-full

include(graphics-nvidia-M4_OS_VERSION)

RUN env DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && apt-get -y install \
    git \
    ssh \
    sudo \
    vim \
    && rm -rf /var/lib/apt/lists/*

ARG UID=1000
ARG GID=$UID
ARG USER
RUN groupadd --gid $GID $USER && \
    useradd --create-home \
            -g $USER \
            --groups sudo \
            -u $UID \
            --password "$(openssl passwd -1 $USERNAME)" \
            $USER
USER $USER
WORKDIR /home/$USER
