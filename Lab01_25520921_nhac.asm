.data
    cao_do: .word 64, 64, 65, 67, 67, 65, 64, 62, 60, 60, 62, 64, 64, 62, 62
    do_dai: .word 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 1, 4
    so_not: .word 15
    
    msg_space:  .asciiz " "
    msg_nl:     .asciiz "\n"
    msg_dukien: .asciiz "Tong du kien (ms): "
    msg_doduoc: .asciiz "\nThoi gian do duoc (ms): "

.text
main:
    la $s0, cao_do
    la $s1, do_dai
    lw $s2, so_not
    li $s3, 0
    li $s4, 0

    li $v0, 30
    syscall
    move $s5, $a0

VongLapPhatNhat:
    beq $s3, $s2, KetThucPhat   # Neu da duyet het 15 not thi dung lap

    lw $t0, 0($s0)
    lw $t1, 0($s1)

    addi $t0, $t0, 1
    mul $t1, $t1, 170

    add $s4, $s4, $t1

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, msg_space
    syscall

    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, msg_nl
    syscall

    li $v0, 31
    move $a0, $t0       # $a0 = Cao ?? (Pitch)
    move $a1, $t1       # $a1 = Th?i l??ng
    li $a2, 0           # $a2 = Nh?c c?
    li $a3, 100         # $a3 = Âm l??ng
    syscall
    
    li $v0, 32          # Syscall 32: Sleep
    move $a0, $t1       # $a0 = th?i gian ng? (ms), l?y giá tr? th?i l??ng n?t t? $t1
    syscall

    addi $s3, $s3, 1
    addi $s0, $s0, 4
    addi $s1, $s1, 4

    j VongLapPhatNhat

KetThucPhat:
    li $v0, 30
    syscall
    sub $s6, $a0, $s5

    # T?ng d? ki?n
    li $v0, 4
    la $a0, msg_dukien
    syscall

    li $v0, 1
    move $a0, $s4
    syscall

    # Th?i gian ?o ???c
    li $v0, 4
    la $a0, msg_doduoc
    syscall

    li $v0, 1
    move $a0, $s6
    syscall

# K?t thúc ch??ng trình
    li $v0, 10
    syscall
