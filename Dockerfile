FROM centos:7.2.1511

LABEL Author="Pad0y<github.com/Pad0y>"

ENV PYTHONIOENCODING utf-8

COPY . /data/project/
WORKDIR /data/project/

RUN yum -y update \
    && yum -y install gcc gcc-c++ wget make git libSM-1.2.2-2.el7.x86_64 libXrender libXext\
    && yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel libffi-devel \
    && yum -y install python3-devel centos-release-scl scl-utils-build \
    && yum -y install devtoolset-7-gcc* \
    && yum -y install kde-l10n-Chinese \
    && echo 'source /opt/rh/devtoolset-7/enable' >> ~/.bash_profile \
    && source ~/.bash_profile \
    && scl enable devtoolset-7 bash

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

RUN pip3 install --user  -U pip -i https://pypi.tuna.tsinghua.edu.cn/simple/  \ 
    && pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/ 

RUN source ~/.bash_profile && pip3 install -r requirements.txt

ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8

EXPOSE 5000
EXPOSE 8000

CMD python3 backend/main.py
