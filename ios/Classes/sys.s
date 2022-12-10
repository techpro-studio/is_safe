

#if defined(__arm64__)

.text
.global _frk
.align 4

_frk:
    mov        x0, 1
    mov        x16, 2                // Syscall code
    svc        #0x80               // Trap to kernel
    b.cs       LFail                       // Carry bit indicates failure
    b.cc       LSuccess
    
LFail:
    mov        w0, -1
    ret

LSuccess:
    ret


.text
.global _print
.align 4

_print:
    mov X9, X0
    mov x10, X1
    mov X0, 1
    mov X1, X9
    mov X2, X10
    mov X16, 4
    svc #0x80
    mov X0, 0
    ret


.text
.global _opn
.align 4

_opn:
    mov X16, 5
    svc #0x80
    b.cs       LFail                       // Carry bit indicates failure
    b.cc       LSuccess


.text
.global _wr
.align 4

_wr:
    mov X16, 4
    svc #0x80
    b.cs       LFail                       // Carry bit indicates failure
    b.cc       LSuccess

#endif
