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

                ;; lda #%11111101  ; S
                ;; sta PRA
                ;; lda PRB
                ;; and #%00100000
                ;; beq crouch

                lda #%11111011  ; D
                sta PRA
                lda PRB
                and #%00000100
                beq mobs.ply_moveright

                lda #%11111101  ; A
                sta PRA
                lda PRB
                and #%00000100
                beq mobs.ply_moveleft

                jsr mobs.ply_stop ; getting here means player isn't pressing A or D

                rts
