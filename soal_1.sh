# Durin
auto eth0
iface eth0 inet dhcp
        up echo nameserver 192.168.122.1 > /etc/resolv.conf

auto eth1
iface eth1 inet static
	address 10.71.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 10.71.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 10.71.3.1
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 10.71.4.1
	netmask 255.255.255.0

auto eth5
iface eth5 inet static
	address 10.71.5.1
	netmask 255.255.255.0

sysctl -w net.ipv4.ip_forward=1
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.71.1.0/16
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.71.2.0/16
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.71.3.0/16
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.71.4.0/16
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 10.71.5.0/16
iptables -A OUTPUT -o eth0 -j DROP


# Elendil

auto eth0
iface eth0 inet static
	address 10.71.1.2
	netmask 255.255.255.0
	gateway 10.71.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Isdilur

auto eth0
iface eth0 inet static
	address 10.71.1.3
	netmask 255.255.255.0
	gateway 10.71.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Anarion

auto eth0
iface eth0 inet static
	address 10.71.1.4
	netmask 255.255.255.0
	gateway 10.71.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Miriel
auto eth0
iface eth0 inet static
	address 10.71.1.5
	netmask 255.255.255.0
	gateway 10.71.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Amandil

auto eth0
iface eth0 inet dhcp
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Elros

auto eth0
iface eth0 inet static
	address 10.71.1.7
	netmask 255.255.255.0
	gateway 10.71.1.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Gilgalad

auto eth0
iface eth0 inet dhcp
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Celebrimor

auto eth0
iface eth0 inet static
	address 10.71.2.3
	netmask 255.255.255.0
	gateway 10.71.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Pharazom

auto eth0
iface eth0 inet static
	address 10.71.2.4
	netmask 255.255.255.0
	gateway 10.71.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Galadriel

auto eth0
iface eth0 inet static
	address 10.71.2.5
	netmask 255.255.255.0
	gateway 10.71.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Celeborn

auto eth0
iface eth0 inet static
	address 10.71.2.6
	netmask 255.255.255.0
	gateway 10.71.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Oropher

auto eth0
iface eth0 inet static
	address 10.71.2.7
	netmask 255.255.255.0
	gateway 10.71.2.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Khamul

auto eth0
iface eth0 inet static
	address 10.71.3.2
	netmask 255.255.255.0
	gateway 10.71.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Erendis

auto eth0
iface eth0 inet static
	address 10.71.3.3
	netmask 255.255.255.0
	gateway 10.71.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Amdir

auto eth0
iface eth0 inet static
	address 10.71.3.4
	netmask 255.255.255.0
	gateway 10.71.3.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Aldarion

auto eth0
iface eth0 inet static
	address 10.71.4.2
	netmask 255.255.255.0
	gateway 10.71.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Palantir

auto eth0
iface eth0 inet static
	address 10.71.4.3
	netmask 255.255.255.0
	gateway 10.71.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Narvi

auto eth0
iface eth0 inet static
	address 10.71.4.4
	netmask 255.255.255.0
	gateway 10.71.4.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf

# Minastir

auto eth0
iface eth0 inet static
	address 10.71.5.2
	netmask 255.255.255.0
	gateway 10.71.5.1
    up echo nameserver 192.168.122.1 > /etc/resolv.conf