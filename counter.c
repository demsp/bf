#define F_CPU 16000000UL //16MHz

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{   
	DDRB=0b00001111;
	unsigned char x = 0;
	while (1)
	{
		x++; //C short hand
		PORTB = x & (0x3F); //or: x & (1 + 2 + 4 + 8 + 16 + 32)
	
		_delay_ms(2000);
	}
	
}
