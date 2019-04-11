OS=haribote

default:
	make img

ipl10.bin : ipl10.asm 
	nasm ipl10.asm -o ipl10.bin -l ipl10.lst

asmhead.bin : asmhead.asm
	nasm asmhead.asm -o asmhead.bin -l asmhead.lst

nasmfunc.o : nasmfunc.asm
	nasm -f elf32 -o nasmfunc.o nasmfunc.asm 

bootpack.o : bootpack.c
	gcc -c -m32 -fno-pic -o bootpack.o bootpack.c

bootpack.hrb: bootpack.o nasmfunc.o
	ld -m elf_i386 -e HariMain -o bootpack.hrb -Thrb.ld bootpack.o nasmfunc.o

haribote.sys : asmhead.bin bootpack.hrb
	cat asmhead.bin bootpack.hrb > haribote.sys

$(OS).img : ipl10.bin haribote.sys
	mformat -f 1440 -C -B ipl10.bin -i $(OS).img ::
	mcopy haribote.sys -n -i $(OS).img ::  

img : 
	make $(OS).img

run : 
	qemu-system-i386 -fda $(OS).img

clean :
	rm *.bin *.lst *.hrb *.sys *.img *.o *.img
