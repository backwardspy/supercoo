;;; mob states
MS_NEUTRAL = 1 << 0
MS_WALKING = 1 << 1
MS_CROUCHING = 1 << 2

;;; player constants
PLY_SPEED = 1                   ; pixels/frame

;;; player data
ply_state       .byte MS_NEUTRAL
ply_x0          .byte 0
ply_x           .byte 36
ply_y           .byte 229

ply_delay       .byte %00000001
ply_frame       .byte 0

ply_moveright   lda ply_state
                and #MS_NEUTRAL | MS_WALKING
                bne _move
                rts
_move
                lda #MS_WALKING
                sta ply_state

                lda ply_x
                clc
                adc #PLY_SPEED
                sta ply_x
                bcs flip_x_msb

                rts

ply_moveleft    lda ply_state
                and #MS_NEUTRAL | MS_WALKING
                bne _move
                rts
_move
                lda #MS_WALKING
                sta ply_state

                lda ply_x
                sec
                sbc #PLY_SPEED
                sta ply_x
                bcc flip_x_msb

                rts

flip_x_msb      lda ply_x0
                eor #1
                sta ply_x0
                rts

ply_stop        lda ply_state
                cmp #MS_WALKING
                beq _stop
                rts
_stop
                lda #MS_NEUTRAL
                sta ply_state
                rts

update          lda ply_x0      ; update positions
                sta $D010
                lda ply_x
                sta $D000
                lda ply_y
                sta $D001

                lda ply_state
                cmp #MS_WALKING
                beq _walk

                lda #gfx.spr_addr(pigeon_spr, 0)
                sta gfx.PTR_BASE
                rts

_walk
                lda ply_delay
                clc
                rol
                bcc +
                ora #1
+               sta ply_delay
                and #1
                beq _end

                ldx ply_frame
                inx
                cpx #4
                bne _set_frame
                ldx #0
_set_frame      stx ply_frame
                lda #(pigeon_spr - VIC_BANK) / $40
                clc
                adc ply_frame
                sta gfx.PTR_BASE

_end            rts
