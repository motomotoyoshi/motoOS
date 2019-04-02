# ファイル生成規則

ipl10.bin : ipl10.asm 
	nasm ipl10.asm -o ipl10.bin -l ipl10.lst

haribote.sys : haribote.asm
	nasm haribote.asm -o haribote.sys -l haribote.lst

haribote.img : ipl10.bin haribote.sys
	mformat -f 1440 -B ipl10.bin -C -i haribote.img ::
	mcopy haribote.sys -n -i haribote.img ::  

run : haribote.img
	qemu-system-i386 -fda haribote.img
