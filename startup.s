.syntax unified

/* assemble to THUMB (2 byte) instructions instead of 4-byte arm */
.thumb
.thumb_func

.weak reset_handler
.type reset_handler, %function
reset_handler:
_copy_data:
    ldr r1, =_sidata
    ldr r2, =_sdata
    ldr r3, =_edata
    cmp r2, r3 /* is there any data to copy? */
    bcs _zero_bss /* no data to copy, proceed to zero_bss */
_copy_data_loop:
    /* copy a word and advance the pointers */
    ldr r0, [r1]
    str r0, [r2]
    adds r1, r1, #4
    adds r2, r2, #4
    cmp r2, r3
    bcc _copy_data_loop
_zero_bss:
    movs r0, #0
    ldr r1, =_sbss
    ldr r2, =_ebss
    cmp r1, r2
    bcs _init
_zero_bss_loop:
    /* zero a word and advance the pointer */
    str r0, [r1]
    adds r1, r1, #4
    cmp r1, r2
    bcc _zero_bss_loop
_init:
		/* disable firmware protection here */
    bl main /* call application's entry point */
.size reset_handler, .-reset_handler

.thumb_func
.weak default_handler
.type default_handler, %function
default_handler:
	b default_handler
.size default_handler, .-default_handler

/* rename to match all the handlers */
.thumb_func
.weak nmi_handler
.type nmi_handler, %function
nmi_handler:
	b nmi_handler
.size nmi_handler, .-nmi_handler

.thumb_func
.weak hard_fault_handler
.type hard_fault_handler, %function
hard_fault_handler:
	b hard_fault_handler
.size hard_fault_handler, .-hard_fault_handler

.thumb_func
.weak memory_management_fault_handler
.type memory_management_fault_handler, %function
memory_management_fault_handler:
	b memory_management_fault_handler
.size memory_management_fault_handler, .-memory_management_fault_handler

.thumb_func
.weak bus_fault_handler
.type bus_fault_handler, %function
bus_fault_handler:
	b bus_fault_handler
.size bus_fault_handler, .-bus_fault_handler

.thumb_func
.weak usage_fault_handler
.type usage_fault_handler, %function
usage_fault_handler:
	b usage_fault_handler
.size usage_fault_handler, .-usage_fault_handler

.thumb_func
.weak svc_handler
.type svc_handler, %function
svc_handler:
	b svc_handler
.size svc_handler, .-svc_handler

.thumb_func
.weak pendsv_handler
.type pendsv_handler, %function
pendsv_handler:
	b pendsv_handler
.size pendsv_handler, .-pendsv_handler

.thumb_func
.weak systick_handler
.type systick_handler, %function
systick_handler:
	b systick_handler
.size systick_handler, .-systick_handler
