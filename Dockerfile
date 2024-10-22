FROM rocker/r-base:latest
LABEL maintainer="AFraderaSola <A.FraderaSola@imb-mainz.de>"
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    libgit2-dev\
    libtiff-dev\
    libpng-dev\
    libjpeg-dev\
    libssl-dev\
    zlib1g-dev\
    pandoc\
    libicu-dev\
    libfontconfig1-dev\
    make\
    libxml2-dev\
    git\
    libharfbuzz-dev\
    libfribidi-dev\
    libfreetype6-dev\
    default-jdk \
    r-cran-rjava \
    libcurl4-gnutls-dev \
    libfribidi-dev \
    libxml2-dev \
    libxt-dev \
    libssl-dev \
    cmake \
    libssh2-1-dev \
    libpng-dev \ 
    libtiff5-dev \ 
    libjpeg-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN R -e "install.packages(c('devtools'), dependencies=TRUE, repos='http://cran.rstudio.com/')"
WORKDIR /home/Desktop/ShinyToDocker/Rshinyfly_AFS/
COPY ./RLibraries/cfpscripts_0.4.11.9008.tar.gz .
COPY ./RLibraries/rMQanalysis_0.3.4.9012.tar.gz .
COPY ./RLibraries/Rshinyfly.zip .
RUN R -e "install.packages(c('rMQanalysis_0.3.4.9012.tar.gz', 'cfpscripts_0.4.11.9008.tar.gz'),repos = NULL, type = 'source')"
RUN R -e "devtools::install_local(path = 'Rshinyfly.zip')"
RUN echo "local(options(shiny.port = 3838, shiny.host = '0.0.0.0'))" > /usr/lib/R/etc/Rprofile.site
WORKDIR /home/Desktop/ShinyToDocker/Rshinyfly_AFS/app
COPY app .
EXPOSE 3838
CMD ["R", "-e", "shiny::runApp('/home/Desktop/ShinyToDocker/Rshinyfly_AFS/app/Rshinyfly/Rshinyfly/inst/Rshinyfly')"]
