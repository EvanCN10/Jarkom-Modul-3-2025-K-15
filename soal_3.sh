# MINASTIR
apt update
apt install bind9 -y

# ubah config file ini etc/bind/named.conf.options
options {
    directory "/var/cache/bind";

    // IP DNS publik yang jadi tujuan forwarder
    forwarders {
        8.8.8.8;
        1.1.1.1;
    };

    allow-query { any; };         // izinkan semua client internal
    allow-recursion { any; };     // izinkan rekursi
    dnssec-validation auto;

    auth-nxdomain no;
    listen-on { any; };
    listen-on-v6 { any; };
};

# restart bind9
service named stop
named -g &

# PADA CLIENT
nameserver 10.78.5.2
ping google.com