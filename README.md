# harbor

```bash
# install packages & create certs
$ ./generate_certificates.sh
$ ./download_packages.sh

# vm up
$ vagrant up

# setting harbor
$ vagrant ssh n1
    $ sudo su -
    $ cd /docker/harbor
    $ ./install.sh

# vm down
$ vagrant destroy -f
```