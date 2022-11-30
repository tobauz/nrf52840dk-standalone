#include <stdint.h>

int x;
int y = 3;

#define GPIO_BASE 0x50000000
#define DIR_OFF 0x514
#define OUT_OFF 0x504
#define GPIO_0_DIR ((uint32_t *) (GPIO_BASE + DIR_OFF))
#define GPIO_0_OUT ((uint32_t *) (GPIO_BASE + OUT_OFF))

// LEDs are mapped to bits 13-16 of GPIO_0_OUT

void enableLed(int ledNum) {
	// led numbers are zero-indexed
	// active-low
	*GPIO_0_OUT &= ~(1 << (13 + (ledNum)));	
}

void disableLed(int ledNum) {
	// led numbers are zero-indexed
	*GPIO_0_OUT |= (1 << (13 + (ledNum)));	
}

int main() {
	x = y + y;	
	*GPIO_0_DIR = 0x1E000;
	*GPIO_0_OUT = 0x1E000; // disable all LEDS
	// enableLed(1);
	// enableLed(2);
	// enableLed(3);
	enableLed(0);
	disableLed(2);
	while (1) {
		int i=0;
		while (i < (1<<20)) {
			++i;
		}
		i = 0;
		disableLed(0);
		enableLed(2);
		while (i < (1<<20)) {
			++i;
		}
		i = 0;
		enableLed(0);
		disableLed(2);
	}
}
