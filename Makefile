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
SOURCE = $(foreach var, $(FILES), src/$(var).$(EXT) )
COMPILED_SOURCE = $(foreach var, $(FILES), obj/$(var).o )
LINKED_FILE = obj/$(PROJ).bin
OUTPUT_HEX = obj/$(PROJ).hex
AVRDUDE = avrdude -p $(PMCU) -c $(PROG)

# Defined functions
help:
	@echo "use make <options>"
	@echo "options:"
	@echo "-----------------------------------------"
	@echo "build	:compiles and links the code"
	@echo "clean	:removes all generated files"
	@echo "flash	:flashes the code"
	@echo "help	:displays this help"
	@echo "-----------------------------------------"

obj/%.o: src/%.c
	@-mkdir obj
	@echo Compiling $< ...
	@avr-$(CC) -mmcu=$(MCU) -c $< -o $@ -Wall
	@echo done compiling $<
	@echo --------------------------------------------------
	
$(LINKED_FILE): $(COMPILED_SOURCE)
	@echo Linking to $@ ...
	@avr-$(CC) -mmcu=$(MCU) $(COMPILED_SOURCE) -o $(LINKED_FILE) -Wall
	@echo done Linking

$(OUTPUT_HEX): $(LINKED_FILE)
	@echo Making $@ ...
	@avr-objcopy -j .text -j .data -O ihex $(LINKED_FILE) $(OUTPUT_HEX)
	@echo done
	@echo --------------------------------------------------
	@avr-size --format=avr --mcu=$(MCU) $(LINKED_FILE)

build: $(OUTPUT_HEX)

flash: $(OUTPUT_HEX)
	$(AVRDUDE) -U flash:w:$(OUTPUT_HEX)

clean:
	@rm -r obj
