# otalk-server - XMPP server combined with WebRTC signaling
#
# https://github.com/andyet/otalk-server

# Use Ubuntu Precise(12.04 LTS) as base
FROM ubuntu:12.04

# install necessary tools
RUN apt-get install -y lsb-release wget

# add prosody sources
RUN echo deb http://packages.prosody.im/debian $(lsb_release -sc) main | tee -a /etc/apt/sources.list

# Add universe sources
RUN echo deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe | tee -a /etc/apt/sources.list

# unable to verify certificate locally with docker
# unsure of how to fix
RUN wget --no-check-certificate https://prosody.im/files/prosody-debian-packages.key -O- | apt-key add -

# update sources
RUN apt-get update

# install lua dependencies
RUN apt-get install -y lua-zlib lua-sec-prosody lua-dbi-sqlite3 liblua5.1-bitop-dev liblua5.1-bitop0 

RUN apt-get install -y prosody-trunk
