#include "blink.h"
#define t 1000

void Blink() {
    _delay_ms(t);
    DDRA = 0x01;
    _delay_ms(t);
    DDRA = 0x00;
}