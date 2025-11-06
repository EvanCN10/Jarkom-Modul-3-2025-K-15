# Jarkom-Modul-3-2025-K-15


|No|Nama anggota|NRP|
|---|---|---|
|1. | Evan Christian Nainggolan | 5027241026|
|2. | Az Zahrra Tasya Adelia | 5027241087|

## Soal 1: Konfigurasi Gateway dan IP Statik

**Tujuan:** Mengonfigurasi *Router* Utama (**Durin**) sebagai *Gateway* dan menetapkan semua alamat IP statik pada *node* yang relevan sesuai dengan pembagian *subnet* ($10.71.x.0/24$).

**Hasil Pengerjaan ( $ \text{soal\_1.sh}$):**

* **Konfigurasi Durin (Router):**
    * Mengaktifkan fitur **IP Forwarding** (`sysctl -w net.ipv4.ip_forward=1`).
    * Mengimplementasikan **NAT (Network Address Translation)** menggunakan `iptables` untuk memungkinkan semua *subnet* ($10.71.1.0/16, 10.71.2.0/16, 10.71.3.0/16, \dots$) dapat mengakses jaringan luar melalui `eth0`.
    * Menetapkan IP statik pada *interface* internal (`eth1, eth2, eth3, \dots`) sebagai *Gateway* untuk masing-masing *subnet* (contoh: $10.71.1.1$ untuk *subnet* $10.71.1.0/24$).
* **Konfigurasi Node Statik (Contoh):**
    * Setiap *node* di jaringan Server/Infrastruktur (contoh: **Erendis, Amdir, Khamul**) diberi IP statik di *subnet* mereka masing-masing dan diarahkan ke IP Durin yang sesuai sebagai *Gateway*.
* **Verifikasi:** Konektivitas antar *subnet* dan akses internet dari *node* statik diverifikasi menggunakan `ping`.
<img width="873" height="671" alt="image" src="https://github.com/user-attachments/assets/c0862c71-1603-42be-b0bb-4d2c76edf518" />

---

## Soal:2 Implementasi Layanan DHCP

**Tujuan:** Mengonfigurasi server **Aldarion** sebagai *DHCP Server* dan *Router* **Durin** sebagai *DHCP Relay Agent* untuk melayani klien di dua *subnet* berbeda (**Human Family** $10.71.1.0/24$ dan **Elf Family** $10.71.2.0/24$).

**Hasil Pengerjaan ( $ \text{soal\_2.sh}$):**

* **Konfigurasi Durin (Relay Agent):**
    * Menginstal `isc-dhcp-relay`.
    * Mengonfigurasi `/etc/default/isc-dhcp-relay` untuk meneruskan permintaan dari *interface* klien (`eth1, eth2, \dots`) ke alamat IP **Aldarion** (Server DHCP).
* **Konfigurasi Aldarion (DHCP Server):**
    * Menginstal `isc-dhcp-server`.
    * Mengonfigurasi `/etc/dhcp/dhcpd.conf` dengan dua blok *subnet* yang berbeda:
        * **Human Family ($10.71.1.0/24$):** Menetapkan *range* IP yang spesifik ($10.71.1.6$ hingga $10.71.1.94$), *router* ($10.71.1.1$), dan *lease time* (30 menit).
        * **Elf Family ($10.71.2.0/24$):** Menetapkan *range* IP yang spesifik ($10.71.2.35$ hingga $10.71.2.121$), *router* ($10.71.2.1$), dan *lease time* (10 menit).
        * Semua *client* dikonfigurasi untuk menggunakan *DNS Server* $10.71.3.2$ dan $10.71.4.2$.
* **Verifikasi:** Klien (contoh: **Earendil, Elrond**) dikonfigurasi untuk DHCP dan berhasil mendapatkan IP sesuai *range* yang ditentukan oleh Aldarion.
<img width="849" height="185" alt="Screenshot 2025-11-05 114308" src="https://github.com/user-attachments/assets/5571eaee-c935-4387-8229-2a747b967910" />

---

<img width="866" height="229" alt="Screenshot 2025-11-05 114323" src="https://github.com/user-attachments/assets/05abfe82-c55a-476b-9299-cecd95333f4e" />

---

<img width="851" height="325" alt="Screenshot 2025-11-05 114338" src="https://github.com/user-attachments/assets/91fe6992-06e3-4385-9c89-77078ffbe645" />

---

## Soal 3: Instalasi dan Konfigurasi DNS Forwarder

**Tujuan:** Menginstal **DNS Server** pada *node* **Minastir** dan mengonfigurasinya sebagai **DNS Forwarder** untuk melayani resolusi nama dari jaringan internal ke internet.

**Hasil Pengerjaan ( $ \text{soal\_3.sh}$):**

* **Aksi:** Menginstal `bind9` di **Minastir**.
* **Konfigurasi `/etc/bind/named.conf.options` (Minastir):**
    * Mengatur *forwarders* untuk mengarahkan permintaan DNS eksternal ke DNS publik yang terpercaya (contoh: $8.8.8.8$ dan $1.1.1.1$).
    * Mengizinkan *query* dan *recursion* dari semua *client* internal (`allow-query { any; };`, `allow-recursion { any; };`).
* **Verifikasi:** Klien dikonfigurasi untuk menggunakan Minastir sebagai *nameserver* utama, dan berhasil melakukan `ping google.com`.

---

## Soal 4: Konfigurasi DNS Master-Slave

**Tujuan:** Mengonfigurasi **Erendis** sebagai **DNS Master** dan **Amdir** sebagai **DNS Slave** untuk domain `<KXX.com>`, memastikan *zone transfer* dan redundansi DNS.

**Hasil Pengerjaan ( $ \text{soal\_4.sh}$):**

* **Aksi:** Menginstal `bind9` di **Erendis** dan **Amdir**.
* **Erendis (Master) Konfigurasi:**
    * Di `/etc/bind/named.conf.local`, `type master` diatur untuk zona `<KXX.com>`.
    * `allow-transfer { 10.71.3.4; }` (IP Amdir) dan `notify yes` diaktifkan untuk transfer zona otomatis.
    * File zona (`/etc/bind/db.KXX`) dibuat, mencantumkan **Serial SOA** ($2025103101$) dan semua **NS Records** (`ns1`, `ns2`).
* **Amdir (Slave) Konfigurasi:**
    * Di `/etc/bind/named.conf.local`, `type slave` diatur.
    * `masters { 10.71.3.3; }` (IP Erendis) diatur.
* **Verifikasi:**
    * Setelah *restart* BIND9, `dig @10.71.3.4 <nama\_host>.<KXX.com>` (menggunakan Amdir/Slave) berhasil me-*resolve* nama, membuktikan *zone transfer* dari Erendis (Master) berhasil.

---
