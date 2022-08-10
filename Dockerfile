ARG ROS_DISTRO=noetic

FROM ros:$ROS_DISTRO-ros-core

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
        ros-$ROS_DISTRO-rviz && \
    apt-get upgrade -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

CMD ["rosrun", "rviz", "rviz"]