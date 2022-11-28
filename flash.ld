MEMORY
{
    FLASH   (rx)  : ORIGIN = 0x00000000, LENGTH = 1024K
    SRAM    (rwx) : ORIGIN = 0x20000000, LENGTH = 256K
}

_stack_size = 0x1000;

SECTIONS
{
    /* Stack, placed at bottom of SRAM. */
    .stack (NOLOAD) : {
        . = ALIGN(8);
        _sstack = .;
        . = . + _stack_size;
        . = ALIGN(8);
        _estack = .;
    } > SRAM

    .text : {
        . = ALIGN(4);
        _stext = .;

        /* Vector table at the beginning.
         * First 16 entries in vector table are defined by ARM and common to
         * all ARM chips, followed by chip-specific IRQs. */
        KEEP(*(.vectors))
        ASSERT((. == 0x40), "Error: vector table is wrong size.");
        KEEP(*(.irqs))

        /* Program code. */
        *(.text .text.* .gnu.linkonce.t.*)

        /* Glue between ARM and THUMB code. */
        *(.glue_7)
        *(.glue_7t)

        . = ALIGN(4);
        _etext = .;
    } > FLASH

    /* Constants. */
    .rodata : {
        . = ALIGN(4);
        _srodata = .;

        *(.rodata .rodata.* .gnu.linkonce.r.*)

        . = ALIGN(4);
        _erodata = .;
    } > FLASH

    _eflash = ORIGIN(FLASH) + LENGTH(FLASH);

    /* Data that must be relocated: this is program data that is initialized
     * with a value. */
    _sidata = LOADADDR(.data);
    .data : {
        . = ALIGN(4);
        _sdata = .;

        *(.ramfunc)
        *(.data .data.*)

        . = ALIGN(4);
        _edata = .;
    } > SRAM AT > FLASH

    /* Data that must be zeroed at startup. */
    .bss (NOLOAD) : {
        . = ALIGN(4);
        _sbss = .;

        *(.bss .bss.*)
        *(COMMON)

        . = ALIGN(4);
        _ebss = .;
    } > SRAM

    _esram = ORIGIN(SRAM) + LENGTH(SRAM);

    /DISCARD/ : {
        *(.comment .ARM.attributes)
        *(.ARM.extab.* .gnu.linkonce.armextab.*)
        *(.ARM.exidx.* .gnu.linkonce.armexidx.*)
        *(.eh_frame)
    }
}
