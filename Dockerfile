FROM ubuntu:22.04

# Install packages needed
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install vim curl wget dnsutils telnet iputils-ping

# Configure user environment
COPY ./config/bash_profile /root/.bashrc
#RUN rm -f /root/.bashrc
WORKDIR /root/
