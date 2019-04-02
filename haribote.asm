; moto-OS
; TAB=2

  ORG 0xc200    ; このプログラムがどこに読み込まれるか

  MOV AL,0x13   ; VGAグラフィックス、320x200x8bit カラー
  MOV AH,0x00
  INT 0x10
fin:
  HLT
  JMP fin
