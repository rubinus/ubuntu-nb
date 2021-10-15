FROM ubuntu:20.04
LABEL maintainer="rubinus.chu@mail.com"

#替换aliyun
RUN  sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN  apt clean && apt update

#设置zone为国内
ENV  TZ=Asia/Shanghai
RUN  apt -y install --no-install-recommends tzdata && ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt -y install --no-install-recommends libelf1 binutils python

COPY * /tmp/

RUN dpkg -i /tmp/libbcc*.deb
RUN dpkg -i /tmp/python-bcc*.deb
RUN dpkg -i /tmp/bcc*.deb

RUN rm -rf /tmp/* && rm -rf /var/cache/apk/* && rm -rf /var/lib/apt/lists/* && apt autoremove


