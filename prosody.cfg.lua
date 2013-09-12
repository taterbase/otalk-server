admins = { "ADMIN@HOST" }
daemonize = true
pidfile = "/var/run/prosody/prosody.pid"

modules_enabled = {
    "roster";
    "saslauth";
    "tls";
    "dialback";
    "disco";
    "private";
    "vcard";
    "privacy";
    "compression";
    "smacks3";
    "smacks2";
    "carbons";
    "mam";
    "lastactivity";
    "offline";
    "pubsub";
    "version";
    "uptime";
    "time";
    "ping";
    "pep";
    "register";
    "adhoc";
    "admin_adhoc";
    "posix";
    "bosh";
    "websocket";
};

allow_registration = false;

ssl = {
    key = "/path/to/key";
    certificate = "/path/to/cert";
}

c2s_require_encryption = true
s2s_secure_auth = true

cross_domain_bosh = true

authentication = "internal_hashed"

storage = {archive2 = "sql2"}

sql = { driver = "SQLite3", database = "prosody.sqlite" }

log = {
    debug = "/var/log/prosody/prosody.log";
    error = "/var/log/prosody/prosody.err";
}

VirtualHost "HOST"

component_ports = { 5347 }
Component "muc.HOST" "muc"
