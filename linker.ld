/* ENTRY POINT */
ENTRY(_start)

/* Tell where the various sections of the object files will be put in the final
   kernel image. */
SECTIONS
{
	/* START OFFSET */
	. = 2M; /* The starting address of the kernel in memory is set to 2MB. */

	/* TEXT SECTION */
	.text BLOCK(4K) : ALIGN(4K) /* The code section, aligned to 4KB boundaries. */
	{
		*(.multiboot) /* Includes the Multiboot header, necessary for boot loaders that comply with the Multiboot specification. */
		*(.text)      /* Includes the executable code of the kernel. */
	}

	/* Read-only data. */
	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}

	/* Read-write data (initialized) */
	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}

	/* Read-write data (uninitialized) and stack */
	.bss BLOCK(4K) : ALIGN(4K)
	{
		*(COMMON)
		*(.bss)
	}

	/* TO BE ADDED */
}