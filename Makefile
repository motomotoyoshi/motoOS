OS=haribote

default:
	make img

ipl10.bin : ipl10.asm 
	nasm ipl10.asm -o ipl10.bin -l ipl10.lst

asmhead.bin : asmhead.asm
	nasm asmhead.asm -o asmhead.bin -l asmhead.lst

nasmfuncelf.o : nasmfunc.asm
	nasm -f elf nasmfunc.asm -o nasmfuncelf.o

bootpack.hrb : bootpack.o hrb.ld nasmfuncelf.o
	gcc -c -m32 -fno-pic -nostdlib -T hrb.ld bootpack.c nasmfuncelf.o  -o bootpack.hrb

haribote.oys : asmhead.bin bootpack.hrb
	cat asmhead.bin bootpack.hrb > haribote.oys

$(OS).img : ipl10.bin haribote.oys
	mformat -f 1440 -B ipl10.bin -C -i $(OS).img ::
	mcopy haribote.oys -n -i $(OS).img ::  

img : 
	make $(OS).img

run : 
	qemu-system-i386 -fda $(OS).img

clean :
	rm *.bin *.lst *.hrb *.oys *.img *.o
