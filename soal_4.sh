# setting ERENDIS di ns1.K15.com dan AMDIR ns2.K15.com, pertama install bind9 di ERENDIS dan AMDIR
apt update
apt install bind9 -y

# Config ERENDI (/etc/bind/named.conf.local)
zone "K15.com" {
    type master;
    file "/etc/bind/db.K15";
    allow-transfer { 10.71.3.4; };  # Izinkan transfer ke Amdir (IP Slave)
    notify yes;                    # Beri tahu Slave saat ada update
};

# /etc/bind/db.K15
$TTL    604800
@       IN      SOA     ns1.K15.com. root.K15.com. (
                     2025103101 ; Serial (UBAH INI SETIAP UPDATE)
                      604800     ; Refresh
                       86400     ; Retry
                     2419200     ; Expire
                      604800 )   ; Negative Cache TTL
;
@       IN      NS      ns1.K15.com.
@       IN      NS      ns2.K15.com.

ns1     IN      A       10.71.3.3
ns2     IN      A       10.71.3.4

; Record-record klien:
Palantir IN      A       10.71.4.3
Elros    IN      A       10.71.1.7
Pharazon IN      A       10.71.2.4
Elendil  IN      A       10.71.1.2
Isildur  IN      A       10.71.1.3
Anarion  IN      A       10.71.1.4
Galadriel IN     A       10.71.2.5
Celeborn IN      A       10.71.2.6
Oropher  IN      A       10.71.2.7

# cek serial
named-checkzone K15.com /etc/bind/db.K15

# restart bind9
/etc/init.d/named restart

# config AMDIR /etc/bind/named.conf.local
zone "K15.com" {
    type slave;
    file "/var/lib/bind/db.K15";  <-- Ganti dengan path ABSOLUT
    masters { 10.71.3.3; };
};

# restart lagi
/etc/init.d/named restart

# uji bisa dengan
dig @10.71.3.4 Pharazon.K15.com

# ubah isi bind menjadi milik erendis
nano /etc/bind/db.K15

$TTL    604800
@       IN      SOA     ns1.K15.com. root.K15.com. (
                     2025103102 ; Serial (Wajib diubah saat update)
                      604800     ; Refresh
                       86400     ; Retry
                     2419200     ; Expire
                      604800 )   ; Negative Cache TTL
;
@       IN      NS      ns1.K15.com.
@       IN      NS      ns2.K15.com.

ns1     IN      A       10.71.3.3  ; Erendis
ns2     IN      A       10.71.3.4  ; Amdir

; Record Klien yang Diberi Nama Domain Unik:
Palantir IN      A       10.71.4.3
Elros    IN      A       10.71.1.7
Pharazon IN      A       10.71.2.99
Elendil  IN      A       10.71.1.2
Isildur  IN      A       10.71.1.3
Anarion  IN      A       10.71.1.4
Galadriel IN     A       10.71.2.5
Celeborn IN      A       10.71.2.6
Oropher  IN      A       10.71.2.7

# RESTART BIND9 DENGAN INI
killall named 2>/dev/null
/usr/sbin/named -g &

# CEK IP PHARAZON APAKAH SUDAH DI UPDATE
dig @10.71.3.4 Pharazon.K15.com