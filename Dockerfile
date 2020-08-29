# Dockerfile for creating R container 
# and add specific library needed by projects by DIOS_demonstration/envids
# local build should work, but it no longer has all the updates done 
# docker build -t tin6150/r4envids -f Dockerfile .  | tee Dockerfile.monolithic.LOG

# rscript has its own set of fairly long install...
 
#~~ Zink's system R is 3.4.4, library() | wc = 41

#FROM r-base:3.6.2
FROM r-base:3.6.3
MAINTAINER Tin (at) berkeley.edu

ARG DEBIAN_FRONTEND=noninteractive
ARG TERM=vt100
ARG TZ=PST8PDT 

#ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN echo  ''  ;\
    touch _TOP_DIR_OF_CONTAINER_  ;\
    echo '==================================================================' ;\
    echo "begining docker build process at " | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    echo "installing packages via apt"       | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    echo '==================================================================' ;\
    date                                     | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    apt-get update ;\
    # ubuntu:
    apt-get -y --quiet install git file wget gzip bash tcsh zsh less vim bc tmux screen xterm ;\

    echo '==================================================================' ;\
    echo "install for rstudio GUI (Qt)"      | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    date | tee -a      _TOP_DIR_OF_CONTAINER_                                 ;\
    echo '==================================================================' ;\
    #-- rstudio dont seems to exist in Debian bullseye/sid :/
    #-- apt-get --quiet install rstudio  ;\
    apt-get -y --quiet install r-cran-rstudioapi libqt5gui5 libqt5network5  libqt5webenginewidgets5 qterminal net-tools ;\
    apt-get -y --quiet install apt-file ;\
    apt-file update ;\
    mkdir -p Downloads &&  cd Downloads ;\
    wget --quiet https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb  -O rstudio4deb10.deb ;\
    apt-get -y --quiet install ./rstudio4deb10.deb     ;\
    cd ..    ;\
    echo ""  

COPY . /DIOS_demonstration

RUN echo ''  ;\
    cd   /   ;\
    echo '==================================================================' ;\
    echo '==================================================================' ;\
    echo "installing packages cran packages" | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    echo '==================================================================' ;\
    echo '==================================================================' ;\
    date                                     | tee -a _TOP_DIR_OF_CONTAINER_  ;\
    echo '' ;\
    # call install_Rlibs.sh rather than spell them out here.  docker may cache...
    bash -x ./DIOS_demonstration/install_Rlibs.sh 

    Rscript --quiet --no-readline --slave -e 'library()'   | sort | tee R_library_list.out.txt  ;\
    ls /usr/local/lib/R/site-library                       | sort | tee R-site-lib-ls.out.txt   ;\
    dpkg --list                                            | sort | tee dpkg--list.txt          ;\
    echo "Done installing packages cran packages"          | tee -a _TOP_DIR_OF_CONTAINER_      ;\
    date                                                   | tee -a _TOP_DIR_OF_CONTAINER_      ;\
    echo ""


RUN echo ''  ;\
    echo '==================================================================' ;\
    echo "Pork Barrel: GUI file manager"  |   tee -a _TOP_DIR_OF_CONTAINER_   ;\
    date | tee -a      _TOP_DIR_OF_CONTAINER_                        ;\
    echo '==================================================================' ;\
    echo ''  ;\
    # there is some issue and xfe doesnt get installed :/    moving to create guiDesk container instead
    #-- apt-get install -y --quiet xfe ;\
    date | tee -a      _TOP_DIR_OF_CONTAINER_   ;\
    echo ""

RUN  cd / \
  && touch _TOP_DIR_OF_CONTAINER_  \
  && TZ=PST8PDT date  >> _TOP_DIR_OF_CONTAINER_  \
  && echo  "Dockerfile 2020.0829 1045"  >> _TOP_DIR_OF_CONTAINER_   \
  && echo  "Grand Finale"

#- ENV TZ America/Los_Angeles  
ENV TZ America/Los_Angeles 
# ENV TZ likely changed/overwritten by container's /etc/csh.cshrc
#ENV DOCKERFILE Dockerfile[.cmaq]
# does overwrite parent def of ENV DOCKERFILE
ENV TEST_DOCKER_ENV     this_env_will_be_avail_when_container_is_run_or_exec
ENV TEST_DOCKER_ENV_2   Can_use_ADD_to_make_ENV_avail_in_build_process
ENV TEST_DOCKER_ENV_REF https://vsupalov.com/docker-arg-env-variable-guide/#setting-env-values
# but how to append, eg add to PATH?

#ENTRYPOINT [ "/usr/bin/rstudio" ]
ENTRYPOINT [ "R" ]
# if no defined ENTRYPOINT, default to bash inside the container
