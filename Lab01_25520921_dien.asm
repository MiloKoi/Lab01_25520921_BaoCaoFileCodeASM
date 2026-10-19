.data
     suc_chua:   .word 50, 50, 100, 100, 100, 9599
     gia:	 .word 1620, 1680, 1970, 2520, 2870, 3020
    
     msg_nhap:   .asciiz "Nhap so kWh (0..9999): "
     msg_loi:    .asciiz "Gia tri khong hop le, nhap lai.\n"
     msg_kq1:    .asciiz "Tien dien: "
     msg_kq2:    .asciiz " dong\n"
     
.text
main:
NhapDuLieu:
    li $v0, 4
    la $a0, msg_nhap
    syscall

    li $v0, 5
    syscall
    move $s0, $v0		# $s0 = s? kWh nh?p vào

    sltiu $t0, $s0, 10000	# so sánh 0 <= s0 <= 9999 (so sánh ko d?u)
    beq $t0, $zero, BaoLoi

    j KhoiTaoTinhToan

BaoLoi:
    li $v0, 4
    la $a0, msg_loi
    syscall
    j NhapDuLieu

KhoiTaoTinhToan:
    li $s1, 0
    la $t0, suc_chua
    la $t1, gia

VongLapTinhTien:
    beq $s0, $zero, XuatKetQua

    lw $t2, 0($t0)		# t2 là s?c ch?a b?c ?ó
    lw $t3, 0($t1)		# t3 là ??n giá b?c ?ó

    # So sánh s? ?i?n còn l?i v?i s?c ch?a
    slt $t4, $s0, $t2
    bne $t4, $zero, LayPhanConLai

LayHetSucChua:
    move $t4, $t2
    j TinhTienBacNay

LayPhanConLai:
    move $t4, $s0

TinhTienBacNay:
    mul $t5, $t4, $t3
    add $s1, $s1, $t5		# C?ng d?n vào t?ng ti?n

    sub $s0, $s0, $t4
    
    # T?ng ??a ch? 2 m?ng nh?
    addi $t0, $t0, 4
    addi $t1, $t1, 4
    
    j VongLapTinhTien

XuatKetQua:
    li $v0, 4
    la $a0, msg_kq1
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 4
    la $a0, msg_kq2
    syscall

# Ket thuc chuong trinh
    li $v0, 10
    syscall