reserve_check   .macro name, last_addr
                .cerror * > \last_addr, \name, " overflows reserved area by ", * - \last_addr, " bytes."
                .endm

.include "data/addr_defs.s"

* = $0801

basic_loader    .word (+)
                .word 2019
                .byte $9E, $20
                .null format("%d", entry)
+               .word $0000

  #reserve_check "Loader", $08FF

* = ADDR_MUSIC

.binary "res/music.sid", $7E
#reserve_check "Music", $3FFF

;;; data/sprites.s handles its own addresses
.include "data/sprites.s"
#reserve_check "Sprite data", $7FFF

* = ADDR_CODE

sid_init = ADDR_MUSIC + 0
sid_play = ADDR_MUSIC + 3

entry           lda $0001       ; switch out basic rom to free $A000 - $BFFF for our usage
                and #%11111110
                sta $0001

                #screen.init_vic_bank

                jsr screen.init

                jsr gfx.init_pigeon

mainloop
-               ldx #$FF        ; TEMPORARY vsync, to be replaced with raster interrupt
                cpx $d012
                bne -

                jsr input.check_keys

                jmp mainloop

input           .binclude "engine/input.s"
screen          .binclude "engine/screen.s"
gfx             .binclude "engine/gfx.s"

#reserve_check "Program code", $BFFF
