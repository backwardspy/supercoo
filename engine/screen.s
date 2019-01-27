BASE = VIC_BANK + $0400         ; text ram base addr
COLR = $D800                    ; colour ram base addr

init            ldx #0
                stx $d020
                stx $d021

clear           lda #$20        ; space char
                sta BASE, x
                sta BASE + $100, x
                sta BASE + $200, x
                sta BASE + $2E8, x
                lda #$0e
                sta COLR, x
                sta COLR + $100, x
                sta COLR + $200, x
                sta COLR + $2E8, x
                inx
                bne clear       ; loop until overflow
                rts

init_vic_bank   .macro
                lda $DD00
                and #$FC
                ora #VIC_BANK_MASK
                sta $DD00
                .endm
