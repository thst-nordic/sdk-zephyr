
export ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
source zephyr-env.sh
# rm -rdf sanity*
# ccache -c -z
# time ./scripts/sanitycheck  -x=USE_CCACHE=0 --inline-logs --enable-coverage --coverage-platform arm -N -a arm --retry-failed 7 -p nrf9160dk_nrf9160 -p nrf9160dk_nrf9160ns -p nrf52dk_nrf52832 -p nrf52840dk_nrf52840 --subset 1/200
# ccache -s


# rm -rdf sanity*
# ccache -c -z
# time ./scripts/sanitycheck -x=USE_CCACHE=1 --inline-logs --enable-coverage --coverage-platform arm -N -a arm --retry-failed 7 -p nrf9160dk_nrf9160 -p nrf9160dk_nrf9160ns -p nrf52dk_nrf52832 -p nrf52840dk_nrf52840 --subset 1/200
# echo Normal   76s
# ccache -c -z
# time ./scripts/sanitycheck -x=USE_CCACHE=1 --inline-logs --enable-coverage --coverage-platform arm -N -a arm --retry-failed 7 -p nrf9160dk_nrf9160 -p nrf9160dk_nrf9160ns -p nrf52dk_nrf52832 -p nrf52840dk_nrf52840 --subset 1/200
# ccache -s

# echo OUT folder 51
# ccache -c -z
# # rm -rdf /run/out/*
# cp -r /run/out/sanity-out /run/ram/sanity-out
# time ./scripts/sanitycheck -x=USE_CCACHE=1 --no-clean --outdir /run/out/sanity-out --inline-logs --enable-coverage --coverage-platform arm -N -a arm --retry-failed 7 -p nrf9160dk_nrf9160 -p nrf9160dk_nrf9160ns -p nrf52dk_nrf52832 -p nrf52840dk_nrf52840 --subset 1/200
# ccache -s

# echo OUT folder
# ccache -c -z
# time ./scripts/sanitycheck -x=USE_CCACHE=1 --no-clean --outdir /out/sanity-out --inline-logs --enable-coverage --coverage-platform arm -N -a arm --retry-failed 7 -p nrf9160dk_nrf9160 -p nrf9160dk_nrf9160ns -p nrf52dk_nrf52832 -p nrf52840dk_nrf52840 --subset 1/200
# ccache -s

# echo RAM DISK   25,21
# ccache -c -z
# # rm -rdf /run/out/sanity-out
# rm -rdf /run/ram/sanity-out
# cp -r /run/out/sanity-out /run/ram/sanity-out
# time ./scripts/sanitycheck -x=USE_CCACHE=1 --no-clean --outdir /run/ram/sanity-out --inline-logs --enable-coverage --coverage-platform arm -N -a arm --retry-failed 7 -p nrf9160dk_nrf9160 -p nrf9160dk_nrf9160ns -p nrf52dk_nrf52832 -p nrf52840dk_nrf52840 --subset 1/200
# # rm -rdf /run/out/sanity-out
# # cp -r /run/ram/sanity-out /run/out/sanity-out
# ccache -s


echo RAM DISK      load:100     input:21   reload:28
ccache -c -z


echo SETUP
time ./scripts/sanitycheck -x=USE_CCACHE=1 --no-clean --outdir /run/ram/build --inline-logs --enable-coverage --coverage-platform arm -N -a arm --retry-failed 7 -p nrf9160dk_nrf9160 -p nrf9160dk_nrf9160ns -p nrf52dk_nrf52832 -p nrf52840dk_nrf52840
rm -rdf /run/input/build
cp -r /run/ram/* /run/input
rm -rdf /run/input/.ccache
cp -r /home/.ccache /run/input/


# echo ACTUAL RUN
# rm -rdf /run/ram/build
# cp -r /run/input/build /run/ram/
# rm -rdf /home/.ccache
# cp -r /run/input/.ccache /home
# time ./scripts/sanitycheck -x=USE_CCACHE=1 --no-clean --outdir /run/ram/build --inline-logs --enable-coverage --coverage-platform arm -N -a arm --retry-failed 7 -p nrf9160dk_nrf9160 -p nrf9160dk_nrf9160ns -p nrf52dk_nrf52832 -p nrf52840dk_nrf52840
# ccache -s


