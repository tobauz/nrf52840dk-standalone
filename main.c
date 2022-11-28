#include <stdint.h>

int x;
int y = 3;

#define GPIO_BASE 0x50000000
#define DIR_OFF 0x514
#define OUT_OFF 0x504
#define GPIO_0_DIR ((uint32_t *) (GPIO_BASE + DIR_OFF))
#define GPIO_0_OUT ((uint32_t *) (GPIO_BASE + OUT_OFF))

int main() {
	x = y + y;	
	*GPIO_0_DIR = 0x1E000;
	*GPIO_0_OUT = 0x18000;	
	while (1) {
	}
}
