#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../libc/string.h"
#include "kernel.h"

void main(void)
{
    isr_install();
    irq_install();

    kprint("Welcome to Exedo-OS!\n");
    kprint("> ");
}

void user_input(char* input)
{
    if (strcmp(input, "END") == 0)
    {
        kprint("Stopping the CPU. Bye ! \n");
        asm volatile("hlt");
    }

    kprint("Exedo-OS Shell: Command not found \n");
    kprint("> ");
}