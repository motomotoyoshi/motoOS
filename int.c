#include "bootpack.h"

// PICの初期化
void init_pic(void){
  io_out8(PIC0_IMR,  0xff  ); //全ての割り込みを受け付けない
  io_out8(PIC1_IMR,  0xff  ); //全ての割り込みを受け付けない

  io_out8(PIC0_ICW1, 0x11  ); //エッジトリガーモード
  io_out8(PIC0_ICW2, 0x20  ); //IRQ0-7はINT20-27で受ける
  io_out8(PIC0_ICW3, 1 << 2); //PIC1はIRQ2にて接続
  io_out8(PIC0_ICW4, 0x01  ); //ノンバッファモード

  io_out8(PIC1_ICW1, 0x11  ); //エッジトリガーモード
  io_out8(PIC1_ICW2, 0x28  ); //IRQ8-15はINT28-2fで受ける
  io_out8(PIC1_ICW3, 2     ); //PIC1はIRQ2にて接続
  io_out8(PIC1_ICW4, 0x01  ); //ノンバッファモード

  io_out8(PIC0_IMR,  0xfb  ); //11111011 PIC1以外は全て禁止
  io_out8(PIC1_IMR,  0xff  ); //11111111 全ての割り込みを受け付けない

  return;
}

void inthandler21(int *esp){
  struct BOOTINFO *binfo = (struct BOOTINFO *) ADR_BOOTINFO;
  boxfill8(binfo->vram, binfo->scrnx, COL8_000000, 0, 0, 32 * 8 -1, 15);
  putfonts8_asc(binfo->vram, binfo->scrnx, 0, 0, COL8_FFFFFF, "INT 21 (IRQ-1) : PS/2 keyboard");
  for(;;){
    io_hlt();
  }
}

void inthandler2c(int *esp){
  struct BOOTINFO *binfo = (struct BOOTINFO *) ADR_BOOTINFO;
  boxfill8(binfo->vram, binfo->scrnx, COL8_000000, 0, 0, 32 * 8 -1, 15);
  putfonts8_asc(binfo->vram, binfo->scrnx, 0, 0, COL8_FFFFFF, "INT 2c (IRQ-12) : PS/2 mouse");
  for(;;){
    io_hlt();
  }
}

void inthandler27(int *esp){
  io_out8(PIC0_OCW2, 0x67);
  return;
}
