FROM registry.fedoraproject.org/fedora:37

LABEL maintainer="Akashdeep Dhar <t0xic0der@fedoraproject.org>"
LABEL builder=true

# Fill in these environment variables before building from the Dockerfile

ENV WORKDRCT="ENTER_YOUR_WORKDRCT_HERE"
# For eg. "/code"

ENV KERBUSER="ENTER_YOUR_KERBUSER_HERE"
# For eg. t0xic0der@FEDORAPROJECT.ORG

ENV KERBPASS="ENTER_YOUR_KERBPASS_HERE"
# For eg. "XXXXXXXX"

WORKDIR $WORKDRCT

ENV SP01="Install the development dependency packages"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP01" && \
    sudo dnf install gcc git krb5-devel krb5-workstation poetry python3-devel python3-pip --assumeyes && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP01"

ENV SP02="Clone the project repository locally"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP02" && \
    git clone https://github.com/t0xic0der/fuas.git $WORKDRCT && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP02"

ENV SP03="Add the required workarounds to allow for authentication"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP03" && \
    sed -ri "s/default_ccache_name/#default_ccache_name/g" /etc/krb5.conf && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP03"

ENV SP04="Authenticate a new session in the mentioned realm"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP04" && \
    echo -n $KERBPASS | kinit $KERBUSER && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP04"

ENV SP05="Install the project assets in the root directory"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP05" && \
    poetry config virtualenvs.create false && \
    poetry install && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP05"

ENV SP06="Fetch the list and count of active usernames from Datagrepper"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP06" && \
    fuas namelist && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP06"

# ENV SP05="Uncomment this step and comment the previous step to get debugging outputs"
# RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP05" && \
#     fuas --help && \
#     echo $(date +%Y%m%d-%H%M%Z) > /var/tmp/actvfile && \
#     echo $(date +%Y%m%d-%H%M%Z) > /var/tmp/acqtfile && \
#     echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP05"

ENV SP07="Copy over the file to the project directory"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP07" && \
    cp /var/tmp/namefile $WORKDRCT/data/namefile && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP07"
