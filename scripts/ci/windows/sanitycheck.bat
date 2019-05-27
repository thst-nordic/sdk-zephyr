@echo off

call .\zephyr-env.cmd
echo ZEPHYR_BASE=%ZEPHYR_BASE%
set ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
set GNUARMEMB_TOOLCHAIN_PATH=C:\gnuarmemb

python sanitycheck --build-only --board nrf52_pca10040 --tag introduction --ninja --disable-size-report

