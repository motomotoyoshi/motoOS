; nasmfunc
; TAB=2

;[FORMAT "WCOFF"]    ; オブジェクトファイルを作るモード
BITS 32           ; 32ビットモード用の機械語を作らせる


; オブジェクトファイルのための情報

;[FILE "nasmfunc.asm"] ; ソースファイル名情報

GLOBAL  io_hlt ; このプログラムに含まれる関数名


; 以下は実際の関数

SECTION .text     ; オブジェクトファイルではこれを書いてからプログラムを書く

io_hlt:   ; void io_hlt(void);
  HLT
  RET
