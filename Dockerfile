# This is a comment
#FROM ubuntu:18.04
FROM ros:melodic

MAINTAINER Jiangxumin <jxm_zn@163.com>

USER    root
WORKDIR /root

COPY init.sh /root
COPY cfg/cpp /root/cpp

RUN bash -c /root/init.sh
##  添加 科大ROS源
RUN sh -c '. /etc/lsb-release && echo "deb http://mirrors.ustc.edu.cn/ros/ubuntu/ $DISTRIB_CODENAME main" > /etc/apt/sources.list.d/ros-latest.list' &&\
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654 &&\
	apt-get update 
#
RUN   apt-get install -y \
	     iputils-ping \
		 apt-transport-https \
		 ca-certificates \
		 gnupg-agent \
		 software-properties-common  \
		 iproute2 \
		 git  \
		 openssh-client \
		 libnlopt-dev \
		 vim  && \
     apt-get install -y python-bloom=0.10.7-100 fakeroot=1.22-2ubuntu1 &&\
		apt-get clean   

RUN apt-get install -y  \
		build-essential gcc make cmake  &&\
		apt-get clean   

RUN apt-get install -y qt5-assistant qttools5-dev-tools libopenni-dev ros-melodic-pcl-ros 
RUN mkdir -p /root/lidar_align/src &&\
 	git clone --depth 1  https://hub.fastgit.org/ethz-asl/lidar_align.git /root/lidar_align/src/lidar_align &&\ 
	cp /root/lidar_align/src/lidar_align/NLOPTConfig.cmake /root/lidar_align/src/ &&\ 
	cd  /root/lidar_align/ &&\ 
	rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO &&\
	rm /usr/include/flann/ext/lz4.h &&\
	rm /usr/include/flann/ext/lz4hc.h &&\
	ln -s /usr/include/lz4.h /usr/include/flann/ext/lz4.h &&\
	ln -s /usr/include/lz4hc.h /usr/include/flann/ext/lz4hc.h &&\ 
	cp -rf /root/cpp/loader.cpp  /root/lidar_align/src/lidar_align/src/loader.cpp &&\
	bash -c "source /opt/ros/melodic/setup.bash;catkin_make"

#imu_utils
#git clone https://github.com/gaowenliang/code_utils
#https://github.com/gaowenliang/imu_utils

RUN apt-get install -y libdw-dev libceres-dev &&\
mkdir -p /root/imu_calibration_toos/src &&\ 
git clone --depth 1 https://hub.fastgit.org/gaowenliang/code_utils.git /root/imu_calibration_toos/src/code_utils &&\
sed -i "s/backward.hpp/code_utils\/backward.hpp/" /root/imu_calibration_toos/src/code_utils/src/sumpixel_test.cpp &&\
cd /root/imu_calibration_toos/; bash -c "source /opt/ros/melodic/setup.bash;catkin_make" &&\
git clone --depth 1 https://hub.fastgit.org/gaowenliang/imu_utils.git /root/imu_calibration_toos/src/imu_utils &&\
cd /root/imu_calibration_toos/; bash -c "source /opt/ros/melodic/setup.bash;catkin_make" 

#EXPOSE 22
# CMD ["/root/run.sh"]
