# AVR Sample
## Environment:
OS: Ubuntu
with
```bash
sudo apt install gcc-avr avr-libc avrdude
```
MCU: Atmega 32 A [m32](https://ww1.microchip.com/downloads/en/DeviceDoc/Atmega32A-DataSheet-Complete-DS40002072A.pdf)

Programmer: USBASP

## Compile Steps:

```bash
avr-gcc -g -Os -mmcu=atmega32 -c main.c
avr-gcc -g -mmcu=atmega32 -o main.elf main.o
avr-objcopy -j .text -j .data -O ihex main.elf main.hex
avr-size --format=avr --mcu=atmega32 main.elf 
```
