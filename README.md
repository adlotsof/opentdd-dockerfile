# Opentdd Docker

This dockerfile makes it easy running opentdd server on different architectures than amd64. Its cloning the opentdd git repo and builds the server from sourcecode.

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