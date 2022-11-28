build:
	arm-none-eabi-gcc -c -ffreestanding -mthumb -g main.c
	arm-none-eabi-gcc -c -ffreestanding -mthumb -g vectors.s
	arm-none-eabi-gcc -c -ffreestanding -mthumb -g startup.s
	arm-none-eabi-ld -g -T flash.ld vectors.o startup.o main.o -o main.elf
	arm-none-eabi-objcopy -O ihex main.elf main.hex
	arm-none-eabi-objdump --disassemble-all --source --section-headers --demangle main.elf > main.lst

clean:
	rm -f vectors.o 
	rm -f startup.o 
	rm -f main.o 
	rm -f main.elf
	rm -f main.hex
	rm -f main.lst
