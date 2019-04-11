; nasmfunc
; TAB=2

BITS 32           ; 32ビットモード用の機械語を作らせる

GLOBAL  io_hlt, write_mem8 ; このプログラムに含まれる関数名
SECTION .text     ; オブジェクトファイルではこれを書いてからプログラムを書く
io_hlt:   ; void io_hlt(void);
  HLT
  RET

write_mem8: ; void write_mem8(int addr, int date);
  MOV   ECX,[ESP+4] ; [ESP+4]にaddrが入っているのでそれをECXに読み込む
  MOV   AL,[ESP+8] ;  [ESP+8]にdataが入っているのでそれをALに読み込む
  MOV   [ECX],AL
  RET
