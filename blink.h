#ifndef BLINK
#define BLINK

#ifndef F_CPU
#define F_CPU 8000000UL
#endif

#include <avr/io.h>
#include <util/delay.h>

void Blink(void);

#endif