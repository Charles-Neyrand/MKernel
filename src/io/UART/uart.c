#include "uart.h"

const uint64_t DR = 0x9000000;
const uint64_t FR = 0x9000018;
char *volatile UARTDR = (char *)DR;
char *volatile UARTFR = (char *)FR;

static void uart_wait()
{
    int mask = 1 << 3;

    while (*UARTFR & mask);
}

void putc(char c)
{
    *UARTDR = c;
    uart_wait();
}

void puts(char *s)
{
    for (; *s; ++s)
        putc(*s);
}

int getc()
{
    while (*UARTFR & (1 << 4));

    int c = *UARTDR;
    return c;
}

