FROM alpine:latest
RUN apk add --no-cache clang musl-dev curl meson ninja pkgconfig git nasm
RUN git clone --branch 1.3.0 --depth 1 https://code.videolan.org/videolan/dav1d.git /dav1d_src
ENV PKG_CONFIG_PATH=/dav1d/lib/pkgconfig
ENV LD_LIBRARY_PATH=/dav1d/lib
WORKDIR /dav1d_src
RUN meson build -Dprefix=/dav1d -Denable_tools=false -Denable_examples=false -Ddefault_library=static --buildtype release
RUN ninja -C build && ninja -C build install
WORKDIR /dav1d
CMD ["sh"]
