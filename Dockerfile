FROM ubuntu:18.04 
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:team-xbmc/ppa \
	&& apt-get update && apt-get install -y  \
		kodi \
		xrdp \
	&& apt-get -y --purge autoremove \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/cache/samba && chmod 777 /var/cache/samba

ENV TZ 'Europe/Berlin'
RUN echo $TZ > /etc/timezone \
    && apt-get update && apt-get install -y tzdata \
    && rm /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#RUN if [ -f /etc/localtime ]; then unlink /etc/localtime; fi \
#	&& ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime



ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN usermod -a -G ssl-cert xrdp

ARG KODIUSERNAME=kodiuser
ENV KODIUSERNAME=$KODIUSERNAME
RUN adduser --disabled-password --gecos "" $KODIUSERNAME \
	&& echo "kodi" > /home/$KODIUSERNAME/.xsession

EXPOSE 3389/tcp

VOLUME ["/home/$KODIUSERNAME/.kodi"]
ENTRYPOINT [ "/entrypoint.sh" ]
