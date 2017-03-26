#!/bin/bash
mkdir -p downloader nginx/config mysql phpfpm/config phpfpm/app
mv Dockerfile1 mysql/Dockerfile
mv Dockerfile2 phpfpm/Dockerfile
mv Dockerfile3 nginx/Dockerfile
mv Dockerfile4 downloader/Dockerfile
mv run2.sh phpfpm/run.sh
mv run4.sh downloader/run.sh
mv startdb.sh mysql/
mv php-fpm.conf phpfpm/config/
mv www.conf phpfpm/config/
mv default.conf nginx/config/
mv nginx.conf nginx/config/
cd mysql
docker build -t ahmed_essam/mysql .
cd ..
cd downloader
docker build -t ahmed_essam/downloader .
cd ..
cd phpfpm
docker build -t ahmed_essam/phpfpm .
cd ..
cd nginx
docker build -t ahmed_essam/nginx .
cd ..
docker run -d --name mysql ahmed_essam/mysql
docker run -it --name downloader ahmed_essam/downloader
docker run -d --name app1 --volumes-from downloader --link mysql:db ahmed_essam/phpfpm
docker run -d -p 80:80 --name nginx --volumes-from downloader --link app1:app1 ahmed_essam/nginx







