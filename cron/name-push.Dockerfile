FROM registry.fedoraproject.org/fedora:37

LABEL maintainer="Akashdeep Dhar <t0xic0der@fedoraproject.org>"
LABEL builder=true

# Fill in these environment variables before building from the Dockerfile

ENV WORKDRCT="ENTER_YOUR_WORKDRCT_HERE"
# For eg. "/code"

ENV USERNAME="ENTER_YOUR_USERNAME_HERE"
# For eg. "Akashdeep Dhar"

ENV USERMAIL="ENTER_YOUR_USERMAIL_HERE"
# For eg. "akashdeep.dhar@gmail.com"

ENV GTHBUSER="ENTER_YOUR_GTHBUSER_HERE"
# For eg. "t0xic0der"

ENV GHBTOKEN="ENTER_YOUR_GHBTOKEN_HERE"
# For eg. "ghp_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

ENV REPOLOCA="ENTER_YOUR_REPOLOCA_HERE"
# For eg. "github.com/t0xic0der/fuas.git"

ENV KERBUSER="ENTER_YOUR_KERBUSER_HERE"
# For eg. t0xic0der@FEDORAPROJECT.ORG

ENV KERBPASS="ENTER_YOUR_KERBPASS_HERE"
# For eg. "XXXXXXXX"

WORKDIR $WORKDRCT

ENV SP01="Install the development dependency packages"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP01" && \
    sudo dnf install gcc git krb5-devel krb5-workstation poetry python3-devel python3-pip --assumeyes && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP01"

ENV SP02="Configure Git before starting off with any Git related operations"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP02" && \
    git config --global --add safe.directory $(realpath $WORKDRCT) && \
    git config --global user.email $USERMAIL && \
    git config --global user.name $USERNAME && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP02"

ENV SP03="Clone the project repository locally"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP03" && \
    git clone https://$GTHBUSER:$GHBTOKEN@$REPOLOCA $WORKDRCT && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP03"

ENV SP04="Add the required workarounds to allow for authentication"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP04" && \
    sed -ri "s/default_ccache_name/#default_ccache_name/g" /etc/krb5.conf && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP04"

ENV SP05="Authenticate a new session in the mentioned realm"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP05" && \
    echo -n $KERBPASS | kinit $KERBUSER && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP05"

ENV SP06="Install the project assets in the root directory"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP06" && \
    poetry config virtualenvs.create false && \
    poetry install && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP06"

ENV SP07="Fetch the list and count of active usernames from Datagrepper"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP07" && \
    fuas namelist && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP07"

# ENV SP07="Uncomment this step and comment the previous step to get debugging outputs"
# RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP07" && \
#     fuas --help && \
#     echo $(date +%Y%m%d-%H%M%Z) > /var/tmp/actvfile && \
#     echo $(date +%Y%m%d-%H%M%Z) > /var/tmp/acqtfile && \
#     echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP07"

ENV SP08="Pull the most recently made changes before moving in the modified files"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP08" && \
    git pull origin main && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP08"

ENV SP09="Copy over the file to the project directory"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP09" && \
    cp /var/tmp/namefile $WORKDRCT/data/namefile && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP09"

ENV SP10="Commit the changes to the local repository"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP10" && \
    git commit -asm "$(date +%Y%m%d-%H%M%Z): $(cat /__w/fuas/fuas/data/namefile | wc -l) username(s) available" && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP10"

RUN SP11="Push the new changes to the remote repository"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $SP11" && \
    git push origin main && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $SP11"
