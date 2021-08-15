

    #sudo docker run -d --restart=always -privileged  --name=smart -p 1022:22 --dns=114.114.114.114 --dns=180.76.76.76 smart:v1.0.0

    local devices=""
    devices="${devices} $(find_device ttyUSB*)"
    devices="${devices} $(find_device ttyS*)"
    #devices="${devices} $(find_device can*)"
    devices="${devices} $(find_device ram*)"
    devices="${devices} $(find_device loop*)"
    USER_ID=$(id -u)
    LOCAL_HOST=`hostname`

    HOSTNAME=`hostname`
    IMG="smart:v1.2.0"
    NAME="smart-v2"

    docker run --restart=always \
        -d \
        --name ${NAME} \
        -e USER=$USER \
        -e DOCKER_USER_ID=$USER_ID \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v /opt:/opt \
        -v /etc/localtime:/etc/localtime:ro \
        --net host \
        -w /root \
        ${devices} \
        --add-host ${LOCAL_HOST}:127.0.0.1 \
        --hostname ${HOSTNAME} \
        --shm-size 512M \
        $IMG

