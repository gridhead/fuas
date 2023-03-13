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

WORKDIR $WORKDRCT

ENV STP1="Install the development dependency packages"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP1" && \
    sudo dnf install gcc git krb5-devel krb5-workstation poetry python3-devel python3-pip --assumeyes && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP1"

ENV STP2="Configure Git before starting off with any Git related operations"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP2" && \
    git config --global --add safe.directory $(realpath $WORKDRCT) && \
    git config --global user.email $USERMAIL && \
    git config --global user.name $USERNAME && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP2"

ENV STP3="Clone the project repository locally"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP3" && \
    git clone https://$GTHBUSER:$GHBTOKEN@$REPOLOCA $WORKDRCT && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP3"

ENV STP4="Install the project assets in the root directory"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP4" && \
    poetry config virtualenvs.create false && \
    poetry install && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP4"

ENV STP5="Fetch the list and count of active usernames from Datagrepper"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP5" && \
    fuas activity && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP5"

# ENV STP5="Uncomment this step and comment the previous step to get debugging outputs"
# RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP5" && \
#     fuas --help && \
#     echo $(date +%Y%m%d-%H%M%Z) > /var/tmp/actvfile && \
#     echo $(date +%Y%m%d-%H%M%Z) > /var/tmp/acqtfile && \
#     echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP5"

ENV STP6="Pull the most recently made changes before moving in the modified files"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP6" && \
    git pull origin main && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP6"

ENV STP7="Copy over the file to the project directory"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP7" && \
    cp /var/tmp/actvfile $WORKDRCT/data/actvfile && \
    cp /var/tmp/acqtfile $WORKDRCT/data/acqtfile && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP7"

ENV STP8="Commit the changes to the local repository"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP8" && \
    git commit -asm "$(date +%Y%m%d-%H%M%Z): $(cat $WORKDRCT/data/acqtfile) username(s) active [DEBUG]" && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP8"

RUN STP9="Push the new changes to the remote repository"
RUN echo "[$(date +%Y%m%d-%H%M%Z)] (STRT) $STP9" && \
    git push origin main && \
    echo "[$(date +%Y%m%d-%H%M%Z)] (STOP) $STP9"
