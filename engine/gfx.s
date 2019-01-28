PTR_BASE = screen.BASE + 1000 + 16

spr_addr        .function lbl, frame=0
                .endf ((lbl + frame * $40) - VIC_BANK) / $40

spr_getflags    .macro lbl
                ldx \lbl + $3F
                .endm

init_pigeon     lda #spr_addr(pigeon_spr)
                sta PTR_BASE

                #spr_getflags pigeon_spr

                txa
                rol             ; rotate multi bit into carry
                bcc _nomulti
                lda $D01C
                ora #1
                sta $D01C       ; set sprite 0 multicolour

                lda pigeon_md.mc_0
                sta $D025
                lda pigeon_md.mc_1
                sta $D026

                txa             ; reload flags
                and #$F         ; mask colour bits
                sta $D027       ; store sprite 0 colour

                lda #148        ; x coordinate
                sta $D000
                lda #90         ; y coordinate
                sta $D001

                lda #1          ; enable sprite 0
                sta $D015
_nomulti
                rts
