FROM ubuntu:20.04

COPY app /app
COPY app/* /root/.luarocks/share/lua/5.1/
COPY app/* /.rocks/share/tarantool/

RUN apt-get update
RUN apt-get -y install curl

RUN curl -L https://tarantool.io/tmiDJVT/release/2.8/installer.sh | bash
RUN DEBIAN_FRONTEND=noninteractive apt-get install tarantool -y

RUN apt install git
RUN apt install cmake
RUN apt install make
RUN apt install gcc

RUN tarantoolctl rocks install vshard

ENTRYPOINT ["tarantool"]
CMD ["app/router.lua"]