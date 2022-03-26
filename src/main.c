#ifndef F_CPU
#define F_CPU 8000000UL
#endif

#include <avr/io.h>
#include "blink.h"

int main() {
    DDRA = 0xFF;
    PORTA = 0xFF;
    while(1) {
        Blink();
    }
    return 0;
}