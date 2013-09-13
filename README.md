# OTalk XMPP Server

Any XMPP server that supports websockets would work, but Prosody also supports
some extra features that makes OTalk nicer to use, like message archiving.


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

        sudo cp -r mod_carbons /usr/lib/prosody/modules
        sudo cp -r mod_mam /usr/lib/prosody/modules
        sudo cp -r mod_smacks2 /usr/lib/prosody/modules
        sudo cp -r mod_smacks3 /usr/lib/prosody/modules
        sudo cp -r mod_websocket /usr/lib/prosody/modules

4. Configure Prosody

        sudo cp prosody.cfg.lua /etc/prosody/


## To use &yet authentication

1. Install external auth module

        sudo cp -r mod_auth_external /usr/lib/prosody/modules

2. Modify Prosody config

        VirtualHost "HOST"
            authentication = "external"
            external_auth_command = "andyet-prosody-auth"

3. Install `andyet-prosody-auth`

        npm install -g andyet-prosody-auth

4. Create `/etc/prosody/andyet.json`

        {
            "bucker": {
                "file": {
                    "filename": "/var/log/prosody/auth.log"
                }
                "console": false
            },
            "andyetAuth": {
                "id": "CLIENT ID",
                "secret": "CLIENT SECRET"
            },
            "andyetAPIs": {
                "apps": "https://apps.andyet.com",
                "shippy": "https://api.andbang.com"
            }
        }
