FROM debian:bullseye-slim as build
ENV OPENGFX_VERSION=7.1
RUN apt-get update && apt-get install -y  cmake git
WORKDIR /TDD
RUN git clone https://github.com/OpenTTD/OpenTTD.git .
RUN apt-get install -y build-essential libsdl2-dev
RUN gcc --version
WORKDIR /TDD/build
RUN DCMAKE_BUILD_TYPE=RelWithDebInfo DOPTION_DEDICATED=ON cmake .. 
RUN make
WORKDIR /TDD/build/baseset/
RUN apt-get install -y wget unzip
RUN  wget -q -O opengfx-${OPENGFX_VERSION}.zip \
    https://cdn.openttd.org/opengfx-releases/${OPENGFX_VERSION}/opengfx-${OPENGFX_VERSION}-all.zip ; \
    unzip opengfx-${OPENGFX_VERSION}.zip ; \
    tar -xf opengfx-${OPENGFX_VERSION}.tar ; \
    rm -rf opengfx-*.tar opengfx-*.zip
RUN cp -r /TDD/build/ /tdd
RUN rm -rf /TDD
RUN rm -rf /tdd/CMakeFiles
RUN rm -rf /tdd/src

FROM debian:bullseye-slim as main
COPY --from=build /tdd /tdd
RUN apt-get update && apt-get install -y libsdl2-dev

EXPOSE 3979
ENTRYPOINT ["/tdd/openttd", "-D"]



