# OTalk XMPP Server

## Installation

1. Install Prosody. We want to use message archiving, which requires trunk for now.

    sudo apt-get install prosody-trunk

2. Install additional dependencies

    sudo apt-get install lua-zlib
    sudo apt-get install lua-sec-prosody
    sudo apt-get install lua-dbi-sqlite3
    sudo apt-get install liblua5.1-bitop-dev
    sudo apt-get install liblua5.1-bitop0 

3. Install the included modules

    cp -r mod_carbons /usr/lib/prosody/modules
    cp -r mod_mam /usr/lib/prosody/modules
    cp -r mod_smacks2 /usr/lib/prosody/modules
    cp -r mod_smacks3 /usr/lib/prosody/modules
    cp -r mod_websocket /usr/lib/prosody/modules

4. Configure Prosody

    cp prosody.cfg.lua /etc/prosody/
