ARG ROS_DISTRO=noetic

FROM ros:$ROS_DISTRO-ros-core

RUN apt-get update && apt-get install -y \
        ros-$ROS_DISTRO-rviz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ENV NVIDIA_VISIBLE_DEVICES \
#     ${NVIDIA_VISIBLE_DEVICES:-all}
# ENV NVIDIA_DRIVER_CAPABILITIES \
#     ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

COPY ./ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["rosrun", "rviz", "rviz"]