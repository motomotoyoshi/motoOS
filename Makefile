# ファイル生成規則

ipl.bin : ipl.asm Makefile
    nasm ipl.asm -o ipl.bin -l ipl.lst

helloos.img : ipl.bin Makefile
