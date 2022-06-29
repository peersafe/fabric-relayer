FROM golang:1.18.3 AS build
COPY . /src
WORKDIR /src
RUN GOPROXY=https://goproxy.cn make

FROM ubuntu:latest
WORKDIR /app
COPY --from=build /src/build/bin/relayer /usr/local/bin/relayer
CMD ["/bin/bash"]