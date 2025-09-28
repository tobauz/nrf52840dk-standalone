main.elf: main.c vectors.s startup.s flash.ld
	arm-none-eabi-gcc -c -ffreestanding -mthumb -g main.c
	arm-none-eabi-gcc -c -ffreestanding -mthumb -g vectors.s
	arm-none-eabi-gcc -c -ffreestanding -mthumb -g startup.s
	arm-none-eabi-ld -g -T flash.ld vectors.o startup.o main.o -o main.elf

main.hex: main.elf
	arm-none-eabi-objcopy -O ihex main.elf main.hex
	arm-none-eabi-objdump --disassemble-all --source --section-headers --demangle main.elf > main.lst

recover:
	nrfjprog --recover

flash: main.hex
	nrfjprog -f NRF52 --program main.hex --verify --chiperase
	nrfjprog --reset


clean:
	rm -f vectors.o 
	rm -f startup.o 
	rm -f main.o 
	rm -f main.elf
	rm -f main.hex
	rm -f main.lst

debug-server:
	JLinkGDBServer -device NRF52840_XXAA -if swd -port 2331

debug: main.elf
	arm-none-eabi-gdb -x debug.gdb main.elf
