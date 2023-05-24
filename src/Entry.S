.section ".text.startup"


.global _start
_start:
    ldr x30, =STACK_TOP
    mov sp, x30
	adr x0, evt_el1
	msr VBAR_EL1, x0
    str x0, [sp, #-16]!
    str x1, [sp, #-16]!
    bl kmain
