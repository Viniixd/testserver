FROM debian:buster-slim as build

RUN set -ex && \
       apt-get update && \
       apt-get install -y --no-install-recommends \
       g++ \
       cmake \
       ninja-build \
       libmariadbclient-dev \
       libluajit-5.1-dev \
       libpugixml-dev \
       libgmp3-dev \
       libboost-system1.67-dev && \
       apt-get clean && \
       rm -rf /var/lib/apt/lists

WORKDIR /root/tfs
COPY cmake cmake/
COPY src src/
COPY CMakeLists.txt .
WORKDIR /root/tfs/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DUSE_LUAJIT=1 .. -G Ninja && ninja

# docker build -t registry.gitlab.com/arcadiab78/tfs .
FROM debian:buster-slim
COPY --from=build /root/tfs/build/tfs /usr/local/bin/tfs

RUN set -ex && \
	apt-get update && apt-get upgrade -y && \
	apt-get install -y --no-install-recommends \
	bzip2 \
	libboost-system1.67.0 \
	libgmp10 \
	libluajit-5.1 \
	libmariadb3 \
	libpugixml1v5 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists

WORKDIR /var/lib/tfs

EXPOSE 7171 7172

ENTRYPOINT ["tfs"]
