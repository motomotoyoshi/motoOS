# ファイル生成規則

ipl.bin : ipl.asm 
	nasm ipl.asm -o ipl.bin -l ipl.lst

run : helloos.img
	qemu-system-i386 -fda helloos.img
