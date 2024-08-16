/* Define constants for the multiboot header. */
.set ALIGN,    1<<0             /* Align modules on page boundaries */
.set MEMINFO,  1<<1             /* Provide memory map */
.set FLAGS,    ALIGN | MEMINFO  /* Multiboot 'flag' field */
.set MAGIC,    0x1BADB002       /* Multiboot 'magic number' */
.set CHECKSUM, -(MAGIC + FLAGS) /* Checksum for validity */

/* Multiboot header section, required by the bootloader */
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/* Allocate and align the stack */
.section .bss
.align 16
stack_bottom:
.skip 16384    /* 16 KiB stack */
stack_top:

/* Kernel entry point */
.section .text
.global _start
.type _start, @function
_start:
	/* Set up stack pointer */
	mov $stack_top, %esp

	/* Initialize processor state, GDT, and enable paging here */

	call kernel_main

	/* Halt the CPU when done */
	cli
1:	hlt
	jmp 1b

/* Set the size of _start symbol for debugging purposes */
.size _start, . - _start
