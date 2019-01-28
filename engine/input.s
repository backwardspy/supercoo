PRA = $DC00                     ; CIA1 port regs.
PRB = $DC01
DDRA = $DC02                    ; CIA1 data dir regs.
DDRB = $DC03

KEY_W = $02
KEY_A = $04
KEY_S = $20
KEY_D = $04

check_port      .macro mask
                ldx #\mask
                stx PRA         ; Check selected bit in port A.
                ldx PRB         ; Load result from port B.
                .endm

if_key          .macro mask     ; Branches to + unless key is set.
                txa             ; Expects X to be set by check_port.
                and #\mask
                beq +
                .endm

check_keys
                lda #%11111111
                sta DDRA

                lda #%00000000
                sta DDRB

                lda #%11111101
                sta PRA
                lda PRB
                and #%00100000
                beq crouch

                ;; lda #gfx.spr_addr(pigeon_spr, 0)
                ;; sta gfx.PTR_BASE ; we're not crouching

                lda #%11111011
                sta PRA
                lda PRB
                and #%00000100
                beq move_right

                lda #%11111101
                sta PRA
                lda PRB
                and #%00000100
                beq move_left

                rts

crouch          lda #gfx.spr_addr(pigeon_spr, 4)
                sta gfx.PTR_BASE
                rts

;;; THIS IS ALL EXPERIMENTAL
;;; MOVEMENT WILL BE SUPER WEIRD UNTIL I FIX THIS
move_right      lda $D000
                adc 2
                sta $D000
                bcc +
                lda #1
                eor $D010       ; flip sprite 0's X MSB
                sta $D010
+
                ldx frame
                inx
                cpx #8
                bne +

                ldx #0
                lda #1
                eor $47f8
                sta $47f8
+
                stx frame
                rts

move_left       clc
                dec $D000
                bcc +
                lda #1
                eor $D010       ; flip sprite 0's X MSB
+               rts


frame .byte 0
