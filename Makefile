OS=haribote
OBJS_BOOTPACK = bootpack.o nasmfunc.o hankaku.o mysprintf.o graphic.o dsctbl.o int.o
GCC = gcc -c -march=i486 -m32 -nostdlib -fno-pic

default:
	make img

%.bin : %.asm
	nasm $< -o $@ -l $*.lst

nasmfunc.o : nasmfunc.asm
	nasm -f elf32 -o $@ $<

mysprintf.o : mysprintf.c
	$(GCC) -fno-builtin -o $@ $< 

%.o : %.c
	$(GCC) -o $@ $<

bootpack.hrb: $(OBJS_BOOTPACK)
	ld -m elf_i386 -e HariMain -o $@ -T hrb.ld $^

haribote.sys : asmhead.bin bootpack.hrb
	cat $^ > $@

$(OS).img : ipl10.bin $(OS).sys
	mformat -f 1440 -C -B $< -i $@ ::
	mcopy $(OS).sys -i $@ ::  

img : 
	make $(OS).img

run : 
	qemu-system-i386 -fda $(OS).img

clean :
	rm *.bin *.lst *.hrb *.sys *.img *.o

