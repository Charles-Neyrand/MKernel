#include "exception_handler.h"

#include "../io/UART/uart.h"

void routine_basic(){
	puts("Routine Done\n\r");
	return;
}

void in_el0_routine() {
	puts("In el2\n\r");
	while(1);
}
