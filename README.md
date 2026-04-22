# Proiect-FiiPractic2026-Yonder

Structura:
- EXTRA - cerinte extra pentru proiectul final
- EXTRA-EXTRA - alte exercitii facute pt restul sesiunilor


Dificultati - la proiectul propriuzis nu au existat prea multe din moment ce mai facusem odata 90% acelasi lucru in timpul sesiunilor, am trecut ce probleme/dificultati am mai avut pe parcurs, ce mi-am mai amintit sau ce aveam notat 

## VAGRANT

Am incercat providerul `ansible_local` in `Vagrantfile` pana in saptamana 3-4, dupa care mi-a aparut:

Problema:
- dependinte lipsa din box pentru shared folder: "Vagrant was unable to mount VirtualBox shared folders. This is usually because the filesystem \"vboxsf\" is not available...."

Am incercat:
- `vagrant plugin install vagrant-vbguest`

Problema:
- versiuni diferite: "GuestAdditions versions on your host (7.2.6) and guest (7.2.4) do not match" si eroare la mount shared folder

Am incercat:
- in `Vagrantfile`: `config.vbguest.auto_update=false`
- nu a functionat, nu se facea mount la shared folders: "Vagrant was unable to mount VirtualBox shared folders...."

Problema:
- Vagrant nu putea sa faca update la GuestAdditions pentru ca nu aveam internet pe VM

Am incercat:
- am verificat interfetele
- am verificat rutele; am gasit ca traficul era redirectionat la `192.168.100.1` in loc sa fie catre NAT
- am sters ruta gresita, dar revenea la restart
- ruta la `192.168.100.1` primeste metrica 100 si cade internetul DOAR cand Vagrant incearca sa faca update la GuestAdditions. Nu si daca las optiunea `config.vbguest.auto_update=false`

Am incercat:
- am revenit la shell provision in `Vagrantfile`, dar tot primeam: "GuestAdditions versions on your host (7.2.6) and guest (7.2.4) do not match"

Solutie:
- `config.vbguest.auto_update=false`.
- Acum pot face `vagrant up` pana la capat fara erori, dar fara shared folder.
- Nu vreau sa fac destroy la VM, deoarece ar trebui sa refac configurarile facute la laboratoare.

TL;DR:
- daca e activata optiunea de autoupdate la GuestAdditions, pica internetul pe VM.

## DOCKER

Dupa ce am configurat `container_nginx_2`(sesiunea 4):
- pe `app.fiipractic`, am modificat fisierul standard `nginx.conf`, dar acesta avea optiunea `ssl_ciphers PROFILE=SYSTEM;`.
- imaginea nginx din Docker nu stie ce inseamna `PROFILE=SYSTEM` (specific Red Hat).
- am modificat `nginx.conf` si am refacut containerul cu noul volum `nginx.conf`.

Problema:
- `ERROR [internal] load metadata for docker.io/library/openjdk:11`
- imaginea https://hub.docker.com/_/openjdk este deprecated, am folosit `eclipse-temurin`.

Problema:(sesiunea 5)
- `Error response from daemon: failed to set up container networking: driver failed programming external connectivity on endpoint nginx (...): failed to bind host port 0.0.0.0:80/tcp: address already in use`
- aveam deja pornit pe portul 80 nginx local; l-am inchis ca sa folosesc portul pe containerul Docker.

## GITLAB

Problema:
- la un moment dat primeam 500 pe `https://gitlab.fiipractic.lan`.
- in incognito puteam accesa.
- rezolvare: am sters cookie-urile din browser.

Problema:
- am folosit certificatul creat pe `app.fiipractic.lan`.
- l-am inlocuit cu altul facut pe `gitlab.fiipractic.lan` si l-am adaugat in `/etc/pki/ca-trust/source/anchors`.

Problema:
- permisiunile pentru Docker.
- am adaugat userul `gitlab-runner` la grupul `docker`.

Problema:
- `[ERROR]: Task failed: Failed to connect to the host via ssh: Host key verification failed.`
- am dat manual SSH ca sa accept hostname -> nu a functionat.
- problema era ca pe `gitlab.fiipractic.lan` eram logat ca `root` in loc de `gitlab-runner`.
- pentru automatizare am pus `export ANSIBLE_HOST_KEY_CHECKING=False` inainte sa rulez `ansible-playbook` in `deploy.yml` la stage-ul de deploy.

Problema:
- `dial tcp: lookup gitlab.fiipractic.lan on 100.100.1.1:53: no such host`
- am pus manual `192.168.100.20 gitlab.fiipractic.lan` in `/etc/hosts` pe `app.fiipractic.lan`.
- pentru automatizare am adaugat in `deploy.yml` un task nou cu modulul `lineinfile`.

Problema:
- `Logging into gitlab.fiipractic.lan:5050 for user Ansible failed [...] tls: failed to verify certificate: x509: certificate signed by unknown authority`
- lipsea certificatul de pe masina `gitlab.fiipractic.lan` pe masina `app.fiipractic.lan`.
- l-am adaugat + `update-ca-trust` + restart la Docker.

Problema:
- nu puteam accesa aplicatia `app.fiipractic.lan:8080`.
- lipsea expose la portul `8080` in Docker.