# Openttd Docker

This dockerfile makes it easy running openttd server on different architectures than amd64. Its cloning the openttd git repo and builds the server from sourcecode.

To build the server, simply clone this repo and
```
docker build . --tag=opentdd
```
Then run the image, using your own configuration:
```
docker run -v $(pwd)/conf.cfg:/root/.openttd/openttd.cfg \
           -p 3979:3979/tcp \
           -p 3979:3979/udp \
           opentdd
```
To run on Oracle Cloud Free Infrastructure, a prebuild image exists on docker hub.
```
docker pull adwordsmac1/openttd-arm
```
