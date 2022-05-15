# Build environment
FROM ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang


#RUN apk add --no-cache build-base
WORKDIR /src
COPY . .
RUN make darkhttpd \
 && strip darkhttpd

#WORKDIR /src/devel

#RUN clang -c -Dmain=darkhttpd -g -O2 -fsanitize=fuzzer,address ../darkhttpd.c -o #fuzz_darkhttpd.o
#RUN clang++ -g -O2 -fsanitize=fuzzer,address fuzz_socket.cc fuzz_darkhttpd.o -o fuzz_socket



# Just the static binary
#FROM scratch
#WORKDIR /var/www/htdocs
#COPY --from=build /src/darkhttpd-static /darkhttpd
#EXPOSE 80
#ENTRYPOINT ["/darkhttpd"]
#CMD ["."]

FROM ubuntu:20.04


COPY --from=builder /src/darkhttpd /


#make the binary
#copy it into
