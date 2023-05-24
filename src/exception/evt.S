.section ".text"

.extern routine_basic()
.extern in_el0_routine()

.global evt_el1
.balign 0x800
evt_el1:
// Typical exception vector table code.
curr_el_sp0_sync:        // The exception handler for a synchronous 
	b general_routine
                         // exception from the current EL using SP0.
.balign 0x80
curr_el_sp0_irq:         // The exception handler for an IRQ exception
	b general_routine
                         // from the current EL using SP0.
.balign 0x80
curr_el_sp0_fiq:         // The exception handler for an FIQ exception
	b general_routine
                         // from the current EL using SP0.
.balign 0x80
curr_el_sp0_serror:      // The exception handler for a System Error 
	b general_routine
                         // exception from the current EL using SP0.
.balign 0x80
curr_el_spx_sync:        // The exception handler for a synchrous 
	b general_routine
                         // exception from the current EL using the
                         // current SP.
.balign 0x80
curr_el_spx_irq:         // The exception handler for an IRQ exception from 
	b general_routine
                         // the current EL using the current SP.

.balign 0x80
curr_el_spx_fiq:         // The exception handler for an FIQ from 
	b general_routine
                         // the current EL using the current SP.

.balign 0x80
curr_el_spx_serror:      // The exception handler for a System Error 
	b general_routine
                         // exception from the current EL using the
                         // current SP.

 .balign 0x80
lower_el_aarch64_sync:   // The exception handler for a synchronous 
	b general_routine
                         // exception from a lower EL (AArch64).

.balign 0x80
lower_el_aarch64_irq:    // The exception handler for an IRQ from a lower EL
	b general_routine
                         // (AArch64).

.balign 0x80
lower_el_aarch64_fiq:    // The exception handler for an FIQ from a lower EL
	b general_routine
                         // (AArch64).

.balign 0x80
lower_el_aarch64_serror: // The exception handler for a System Error 
	b general_routine
                         // exception from a lower EL(AArch64).

.balign 0x80
lower_el_aarch32_sync:   // The exception handler for a synchronous 
	b general_routine
                         // exception from a lower EL(AArch32).
.balign 0x80
lower_el_aarch32_irq:    // The exception handler for an IRQ exception 
	b general_routine
                         // from a lower EL (AArch32).
.balign 0x80
lower_el_aarch32_fiq:    // The exception handler for an FIQ exception from 
	b general_routine
                         // a lower EL (AArch32).
.balign 0x80
lower_el_aarch32_serror: // The exception handler for a System Error
	b general_routine
                         // exception from a lower EL(AArch32).


general_routine:
	STP X0, X1, [SP, #-16]!
    STP X2, X3, [SP, #-16]!
	STP X4, X5, [SP, #-16]!
    STP X6, X7, [SP, #-16]!
	STP X8, X9, [SP, #-16]!
    STP X10, X11, [SP, #-16]!
	STP X12, X13, [SP, #-16]!
    STP X14, X15, [SP, #-16]!
	str x30, [sp,-16]!
	bl	  routine_basic

	adr x0, in_el0
	msr ELR_EL1, x0

	mov x0, sp
    msr SP_EL0, x0

	mov x0,xzr
	msr SPSR_EL1, x0


	eret

in_el0:
	bl in_el0_routine
	

