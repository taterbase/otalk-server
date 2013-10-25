# otalk-server - XMPP server combined with WebRTC signaling
#
# https://github.com/andyet/otalk-server

# Use Ubuntu Precise(12.04 LTS) as base
FROM ubuntu:12.04

# install necessary tools
RUN apt-get install -y lsb-release wget git

# add prosody sources (so we can install trunk)
RUN echo deb http://packages.prosody.im/debian $(lsb_release -sc) main | tee -a /etc/apt/sources.list

# Add universe sources (needed for some dependencies)
RUN echo deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe | tee -a /etc/apt/sources.list

# Add key for prosody source
# Note: unable to verify certificate locally with docker
#       unsure of how to fix
RUN wget --no-check-certificate https://prosody.im/files/prosody-debian-packages.key -O- | apt-key add -

# update sources
RUN apt-get update

# install lua dependencies
RUN apt-get install -y lua-zlib lua-sec-prosody lua-dbi-sqlite3 liblua5.1-bitop-dev liblua5.1-bitop0 

RUN apt-get install -y prosody-trunk

# Clone otalk-server goodies
RUN git clone https://github.com/andyet/otalk-server

RUN cp -r otalk-server/mod_carbons /usr/lib/prosody/modules
RUN cp -r otalk-server/mod_mam /usr/lib/prosody/modules
RUN cp -r otalk-server/mod_smacks2 /usr/lib/prosody/modules
RUN cp -r otalk-server/mod_smacks3 /usr/lib/prosody/modules
RUN cp -r otalk-server/mod_websocket /usr/lib/prosody/modules

RUN echo '#!/bin/bash' > setup.sh
RUN echo 'sed -i "s/HOST/$HOST/g" otalk-server/prosody.cfg.lua' >> setup.sh
RUN echo 'cp otalk-server/prosody.cfg.lua /etc/prosody/' >> setup.sh
RUN echo 'USERS=${USERS//,/ }' >> setup.sh
RUN echo 'for user in $USERS; do creds=${user//:/ $HOST }; prosodyctl register $creds; done' >> setup.sh
RUN echo 'tail -f /var/log/prosody/prosody.log' >> setup.sh

RUN chmod 777 setup.sh

EXPOSE  5281:1337

CMD ./setup.sh
