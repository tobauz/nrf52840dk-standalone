.syntax unified

.section .vectors,"ax",%progbits

.global vectors
.type vectors, %object
/* Vector table */
vectors:
    .word _estack /* initial stack pointer */
    .word reset_handler
    .word nmi_handler
    .word hard_fault_handler
		.word memory_management_fault_handler
		.word bus_fault_handler
    .word usage_fault_handler
    .word 0 /* reserved */
    .word 0 /* reserved */
    .word 0 /* reserved */
    .word 0 /* reserved */
    .word svc_handler
    .word 0 /* reserved */
    .word 0 /* reserved */
    .word pendsv_handler
    .word systick_handler
.size vectors, .-vectors
