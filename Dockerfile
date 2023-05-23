ARG ROS_DISTRO=noetic

FROM ros:$ROS_DISTRO-ros-core

SHELL ["/bin/bash", "-c"]

WORKDIR /ros_ws

RUN apt update && apt install -y \
        git \
        python3-dev \
        python3-pip \
        qtbase5-dev \
        qtdeclarative5-dev \
        ros-$ROS_DISTRO-rviz \
        ros-$ROS_DISTRO-rviz-visual-tools && \
    pip3 install \
        rosdep && \
    # rviz_textured_quads pkg
    git clone https://github.com/husarion/rviz_textured_quads.git ./src/rviz_textured_quads && \
    # panther_description pkg
    mkdir -p src/panther_ros && \
    pushd src/panther_ros && \
    git init && \
    git remote add -f origin https://github.com/husarion/panther_ros.git && \
    git sparse-checkout init && \
    git sparse-checkout set "panther_description" && \
    git pull origin ros1 && \
    popd && \
    source /opt/ros/$ROS_DISTRO/setup.bash && \
    rosdep init && \
    rosdep update --rosdistro $ROS_DISTRO && \
    rosdep install --from-paths src -y -i && \
    catkin_make -DCATKIN_ENABLE_TESTING=0 -DCMAKE_BUILD_TYPE=Release && \
    apt-get upgrade -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./ros_entrypoint.sh / 

ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["rosrun", "rviz", "rviz"]