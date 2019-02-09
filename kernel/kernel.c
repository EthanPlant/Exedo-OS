#include "../cpu/isr.h"
#include "../cpu/timer.h"
#include "../drivers/keyboard.h"

void main(void)
{
    isr_install();

    asm volatile("sti");
    init_timer(50); // Comment this out to make keyboard input easier to read

    init_keyboard();
}