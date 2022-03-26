#####################################
# 			  AVR Makefile 			#
# 									#
# created by: github.com/Parthav46  #
#                                   # 
# Makefile to compile, link, encode #
# and flash embedded c or cpp code  #
# for AVR using avr-gcc or avr-g++	#
#####################################

# User variables

# project name (url friendly)
PROJ = test

# compiler type to be used. gcc for C and g++ for CPP
CC = gcc

# type of avr mcu used
MCU = atmega32

# type of avr mcu used for avrdude
PMCU = m32

# list of all files to be compiled (space separated)
FILES = main blink

# type of programmer to be used
PROG = usbasp

#--------(DO NOT EDIT BELOW)--------#

# Generated variables
ifeq ($(CC), gcc)
	EXT = c
else
	EXT = cpp
endif
SOURCE = $(foreach var, $(FILES), $(var).$(EXT) )
COMPILED_SOURCE = $(foreach var, $(FILES), $(var).o )
LINKED_FILE = $(PROJ).bin
OUTPUT_HEX = $(PROJ).hex
AVRDUDE = avrdude -p $(PMCU) -c $(PROG)

# Defined functions
all:

%.o: %.c
	@echo Compiling $< ...
	@avr-$(CC) -mmcu=$(MCU) -c $< -o $@ -Wall
	@echo done compiling $<
	
$(LINKED_FILE): $(COMPILED_SOURCE)
	@echo Linking to $@ ...
	@avr-$(CC) -mmcu=$(MCU) $(COMPILED_SOURCE) -o $(LINKED_FILE) -Wall
	@echo done Linking

$(OUTPUT_HEX): $(LINKED_FILE)
	@echo Making $@ ...
	@avr-objcopy -j .text -j .data -O ihex $(LINKED_FILE) $(OUTPUT_HEX)
	@echo done
	@avr-size --format=avr --mcu=$(MCU) $(LINKED_FILE)

flash: $(PROJ).hex
	$(AVRDUDE) -h flash:w:$(PROJ).hex

clean:
	@rm $(COMPILED_SOURCE) $(LINKED_FILE) $(OUTPUT_HEX)
