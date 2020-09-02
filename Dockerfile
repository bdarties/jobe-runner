FROM ubuntu:18.04

LABEL maintainers="benoit.darties@umontpellier.fr"
ARG TZ=Europe/Paris
ARG ROOTPASS=j0b3r0xx!
COPY main.py /

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV LANG UTF-8.UTF-8

RUN ln -snf /usr/share/zoneinfo/"$TZ" /etc/localtime && \
    echo "$TZ" > /etc/timezone && \
    apt-get update && \
    apt-get --no-install-recommends install -yq apache2 \
    php \
    libapache2-mod-php \
    php-cli \
    php-mbstring \
    octave \
    nodejs \
    git \
    python3 \
    build-essential \
    openjdk-8-jre \
    openjdk-8-jdk \
    python3-pip \
    fp-compiler \
    pylint3 \
    acl \
    sudo \
    sqlite3



 RUN  cd /var/www/html && \
      git clone https://github.com/trampgeek/jobe.git && \
      apache2ctl start  && \
      cd /var/www/html/jobe && \
      ./install  && \
     chown -R www-data:www-data /var/www/html && \
     apt-get -y autoremove --purge && \
     apt-get -y clean && \
     rm -rf /var/lib/apt/lists/*

# export LANG=fr_FR.UTF-8
#   18  sudo service apache2 restart


# Start apache
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]



