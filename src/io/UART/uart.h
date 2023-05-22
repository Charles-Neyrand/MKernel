#ifndef UART_H_
#define UART_H_

#define DEL 127

#include <stdint.h>


void putc(char c);
void puts(char *s);
int getc();

#endif /* !UART_H_ */
