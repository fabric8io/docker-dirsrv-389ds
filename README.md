# 389ds - The Fedora Directory Server

The docker image for installing and running [389ds](http://directory.fedoraproject.org/), inspired by project https://github.com/minkwe/389ds.

This image will be used in fabric8io/fabric8-devops/dirsrv-389ds

# Environment Variables

* `DIRSRV_HOSTNAME` : the hostname to be used with Directory Server, defaults to `hostname --fqdn`
* `DIRSRV_ADMIN_USERNAME` : the admin user name, defaults to `admin`
* `DIRSRV_ADMIN_PASSWORD` : the admin user password, defaults to `admin@123`
* `DIRSRV_MANAGER_PASSWORD` : the diretory manager password, defaults to `admin@123`
* `DIRSRV_SUFFIX` : the directory suffix, defaults to `example.com`

# Volument Mounts

The following are the directories that are exposed and available to be mounted for persistence, by default no persistence is guranteed

`/etc/dirsrv` - the location of instance and configuration data
`/var/lib/dirsrv` - the location of directory server DB
`/var/log/dirsrv` -  the logs of the directory server

# Docker usage

To run the application using a locally installed docker, 

docker run -d --name demo-389ds -e "DIRSRV_ADMIN_USERNAME=myadmin,DIRSRV_ADMIN_PASSWORD=myadminpassword, DIRSRV_MANAGER_PASSWORD=myadminpassword, DIRSRV_SUFFIX=dc=test,dc=org"

`DIRSRV_HOSTNAME` - can be ignored as Docker automatically sets it via `HOSTNAME` variable

# Third-party tools 

The following are are list of third-party tools used and please check the LICENSE of those tools on respective project sites

* https://github.com/toml-lang/toml
* https://github.com/kelseyhightower/confd

# LICENSE

Copyright 2017 Kamesh Sampath

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.