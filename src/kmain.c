#include "io/UART/uart.h"


int kmain(void) {
	puts("Hello World!");
	asm volatile("svc #1");
	while(1);
}
