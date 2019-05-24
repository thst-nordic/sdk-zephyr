@echo off

cd C:\jenkins

cd

rem Initialize west
west init -l zephyr/

echo west init complete

rem Checkout
west  update

echo west update complete