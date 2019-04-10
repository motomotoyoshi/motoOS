; nasmfunc
; TAB=2

BITS 32           ; 32ビットモード用の機械語を作らせる

GLOBAL  io_hlt ; このプログラムに含まれる関数名
SECTION .text     ; オブジェクトファイルではこれを書いてからプログラムを書く

io_hlt:   ; void io_hlt(void);
  HLT
  RET
