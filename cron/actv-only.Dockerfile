FROM registry.fedoraproject.org/fedora:37

LABEL maintainer="Akashdeep Dhar <t0xic0der@fedoraproject.org>"
LABEL builder=true

# Fill in these environment variables before building from the Dockerfile

ENV WORKDRCT="ENTER_YOUR_WORKDRCT_HERE"
# For eg. "/code"

WORKDIR $WORKDRCT

ENV STP1="Install the development dependency packages"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP1" && \
    sudo dnf install gcc git krb5-devel krb5-workstation poetry python3-devel python3-pip --assumeyes && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP1"

ENV STP2="Clone the project repository locally"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP2" && \
    git clone https://github.com/t0xic0der/fuas.git $WORKDRCT && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP2"

ENV STP3="Install the project assets in the root directory"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP3" && \
    poetry config virtualenvs.create false && \
    poetry install && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP3"

ENV STP4="Fetch the list and count of active usernames from Datagrepper"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP4" && \
    fuas activity && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP4"

# ENV STP5="Uncomment this step and comment the previous step to get debugging outputs"
# RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP5" && \
#     fuas --help && \
#     echo $(date +%Y%m%d-%H%M%Z) > /var/tmp/actvfile && \
#     echo $(date +%Y%m%d-%H%M%Z) > /var/tmp/acqtfile && \
#     echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP5"

ENV STP5="Copy over the file to the project directory"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP5" && \
    cp /var/tmp/actvfile $WORKDRCT/data/actvfile && \
    cp /var/tmp/acqtfile $WORKDRCT/data/acqtfile && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP5"
