# Original author: https://github.com/uesyn/neovim-arm64-builder/blob/main/Dockerfile-builder 
#   Original author ref: https://github.com/neovim/neovim/pull/15542/files

# Builds Neovim into a tar.gz
# If you run docker build with the `-o <dir>` flag, it will copy the contents of the final stage out to that dir.
# Exported file: neovim.tar.gz

# Build on the oldest supported images, so we have broader compatibility
FROM ubuntu:22.04 AS build-stage

# these must be passed in via --build-arg
ARG CMAKE_BUILD_TYPE=Release    # Release, Debug or RelWithDebInfo
ARG GIT_TAG=stable              # neovim tag

# Don't ask for TZ information and set a sane default TZ
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# https://github.com/neovim/neovim/wiki/Building-Neovim#ubuntu--debian
## RUN apt-get update && apt-get install -y ninja-build gettext libtool libtool-bin \
##    autoconf automake cmake g++ pkg-config unzip curl doxygen locales git \
RUN apt-get update && apt-get install -y ninja-build gettext cmake unzip curl build-essential \
    # locales is added by the original author
    locales \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN git clone -b ${GIT_TAG} https://github.com/neovim/neovim.git /neovim
WORKDIR /neovim

# https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source
RUN make CMAKE_BUILD_TYPE="${CMAKE_BUILD_TYPE}" \
    CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/opt/neovim" \
    && make install \
    && cd "/opt" \
    && tar cfz neovim.tar.gz neovim

# copy artifacts out of build image
FROM scratch AS export-stage
COPY --from=build-stage /opt/neovim.tar.gz /
