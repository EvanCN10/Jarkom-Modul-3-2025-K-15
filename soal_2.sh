# SETTING DURIN
# install dhcp Relay dahulu
apt-get update
apt-get install isc-dhcp-relay -y

# ubah konfigurasi pada /etc/deafult/isc-dhcp-relay
SERVERS="10.78.4.2"
INTERFACES="eth1 eth2 eth3"
OPTIONS="-a -i eth4"

# SETTING ALDARION
apt-get update
apt-get install isc-dhcp-server -y

# ubah isi nano /etc/dhcp/dhcp.conf menjadi
option domain-name "numenor.lab";
option domain-name-servers 10.71.3.2, 10.71.4.2; # Pindahkan ke global untuk keseragaman, atau biarkan di subnet
default-lease-time 600;
max-lease-time 7200;
authoritative;

# Subnet for Human Family (10.71.1.0/24)
subnet 10.71.1.0 netmask 255.255.255.0 {
    range 10.71.1.6 10.71.1.34;
    range 10.71.1.68 10.71.1.94;

    # Klien akan menggunakan Durin (10.71.1.1) sebagai gateway
    option routers 10.71.1.1;

    # Tambahan dari template yang diminta
    option broadcast-address 10.71.1.255;
    option domain-name-servers 10.71.3.2, 10.71.4.2;

    default-lease-time 1800;
    max-lease-time 3600;
}

# Subnet for Elf Family (10.71.2.0/24)
subnet 10.71.2.0 netmask 255.255.255.0 {
    range 10.71.2.35 10.71.2.67;
    range 10.71.2.96 10.71.2.121;

    # Klien akan menggunakan Durin (10.71.2.1) sebagai gateway
    option routers 10.71.2.1;

    # Tambahan dari template yang diminta
    option broadcast-address 10.71.2.255;
    option domain-name-servers 10.71.3.2, 10.71.4.2;

    default-lease-time 600;
    max-lease-time 3600;
}

# Subnet untuk jaringan Aldarion (server DHCP)
subnet 10.71.4.0 netmask 255.255.255.0 {
    range 10.71.4.10 10.71.4.20;
    option routers 10.71.4.1;

    # Tambahan dari template yang diminta
    option broadcast-address 10.71.4.255;
    option domain-name-servers 10.71.3.2, 10.71.4.2;

    # Tidak perlu lease-time karena IP statis/server
}

# Fixed address for Khamul (di subnet 10.71.3.0/24)
host khamul {
    hardware ethernet 02:42:ab:01:c2:00;
    fixed-address 10.71.3.95;

    # Khamul juga harus tahu gateway dan DNS
    option routers 10.71.3.1;
    option domain-name-servers 10.71.3.2, 10.71.4.2;
}

# ubah /etc/default/isc-dhcp-server menjadi
INTERFACESv4="eth0"
INTERFACESv6=""

# pada client (misal amandil) lakukan restart node, lalu 
ip a show eth0

# aldarion dan start dhcp
service isc-dhcp-server start

# cek ip prosesnya di aldarion 
cat /var/lib/dhcp/dhcpd.leases




