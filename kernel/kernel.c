#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../libc/string.h"

void main(void)
{
    isr_install();
    irq_install();

    kprint("Welcome to Exedo-OS!\n");
}