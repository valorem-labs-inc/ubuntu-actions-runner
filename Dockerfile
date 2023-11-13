FROM ghcr.io/actions/actions-runner:latest

# Run our installations as root
USER root

# Install the core of the system
RUN apt-get update
# Core runner packages
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends vim curl wget dnsutils telnet iputils-ping bzip2 curl g++ gcc git make jq tar unzip wget autoconf automake dbus dnsutils dpkg dpkg-dev fakeroot fonts-noto-color-emoji gnupg2 imagemagick iproute2 iputils-ping libc++abi-dev libc++-dev libc6-dev libcurl4 libgbm-dev libgconf-2-4 libgsl-dev libgtk-3-0 libmagic-dev libmagickcore-dev libmagickwand-dev libsecret-1-dev libsqlite3-dev libyaml-dev libtool libunwind8 libxkbfile-dev libxss1 libssl-dev locales mercurial openssh-client p7zip-rar pkg-config python-is-python3 rpm texinfo tk tzdata upx xorriso xvfb xz-utils zsync acl aria2 binutils bison brotli coreutils file flex ftp haveged lz4 m4 mediainfo netcat net-tools p7zip-full parallel pass patchelf pigz pollinate rsync shellcheck sphinxsearch sqlite3 ssh sshpass subversion sudo swig telnet time zip ca-certificates gnupg libnss3-dev postgresql-client

# Install Docker
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
RUN echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-compose docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Cleanup apt to keep image size down
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to the runner user for launch
USER runner
