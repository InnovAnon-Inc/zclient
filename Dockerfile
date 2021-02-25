FROM innovanon/zandronum as builder
RUN sleep 127                     \
 && apt update                    \
 && apt install                   \
     zandronum-client             \
     zandronum-pk3                \
     doomseeker-zandronum         \
     fluid-soundfont-gm           \
     fluid-soundfont-gs           \
     libcanberra-gtk-module       \
     libfluidsynth1               \
     libglu1-mesa                 \
     libgtk2.0-0                  \
     libsdl1.2debian              \
     libsdl-image1.2              \
 \
 zandronum \
 libxinerama-dev libxrandr-dev x11proto-xinerama-dev \
 x11-xserver-utils \
 strace \
 \
 && usermod -a -G audio zandronum \
 && usermod -a -G video zandronum

## TODO apt remove ...
#
##RUN           tar  cf /tmp/squash.tar     \
##        $(command -v zandronum-server)    \
##/usr/games/zandronum/zandronum-server     \
## /bin /sbin /usr/bin /usr/sbin            \
##                /etc/group                \
##                /etc/passwd               \
## && ldd /bin/bash                         \
##  | sed -n 's@^ *.*=> \(.*\) (.*)$@\1@p'  \
##  | xargs -n1 tar  uf /tmp/squash.tar     \
## && ldd /usr/games/zandronum/zandronum-server \
##  | sed -n 's@^ *.*=> \(.*\) (.*)$@\1@p'  \
##  | xargs -n1 tar  uf /tmp/squash.tar     \
## && mkdir          -v /tmp/squash         \
## &&           tar vxf /tmp/squash.tar     \
##                   -C /tmp/squash
##
#FROM scratch as squash
##COPY --from=builder /tmp/squash/* /
#COPY --from=builder / /
#USER zandronum
#
#FROM squash as test
#RUN test -f /usr/local/lib/libcrypto.so.1.0.0
#RUN test -f /usr/local/lib/libssl.so.1.0.0
#RUN find /home/zandronum/.config/zandronum
###RUN ldd /usr/games/zandronum/zandronum ; exit 2
###RUN ["/usr/bin/zandronum", "--help"]
#
#FROM squash as final
###VOLUME  /root/oblige/wads
###WORKDIR /root/oblige/wads
#
USER zandronum
## TODO brutal doom
## TODO nightly update of latest.wad ?
#ENTRYPOINT ["/usr/bin/zandronum", "zserver:10667"]
ENTRYPOINT ["/usr/bin/zandronum"]
CMD        ["-iwad",   "/home/zandronum/.config/zandronum/freedoom2.wad",     \
            "-waddir", "/home/zandronum/.config/zandronum",                   \
            "-file",   "/home/zandronum/.config/zandronum/brutalv20b.pk3", \
            "-file",   "/home/zandronum/.config/zandronum/rainbow_blood.pk3", \
            "-file",   "/home/zandronum/.config/zandronum/latest.wad",        \
            "+exec",   "/home/zandronum/.config/zandronum/default.cfg"]

