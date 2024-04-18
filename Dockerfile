FROM alpine:edge
RUN apk add --no-cache clang musl-dev curl meson ninja pkgconfig git nasm
COPY dav1d /dav1d_src
WORKDIR /dav1d_src
RUN meson build -Dprefix=/dav1d -Denable_tools=false -Denable_examples=false -Ddefault_library=static --buildtype release
RUN ninja -C build && ninja -C build install

FROM alpine:edge
COPY --from=0 /dav1d /dav1d
WORKDIR /dav1d
CMD ["sh"]
