format ELF64 executable

include "syscalls.asm"

macro print string
{
  mov rdi, string
  call strlen
  mov rdx, rax
  write 1, hello, rdx
}

segment readable executable

;; rdi       - buf
;; retval - rax
strlen:
  xor rax, rax

  .strlenloop:
    cmp byte [rdi], 0
    je .strlenret
    inc rdi
    inc rax
    jmp .strlenloop

  .strlenret:
    ret

entry main
main:
  print hello
  exit 0

segment readable writable

hello db "BananaPants87", 10, 0
