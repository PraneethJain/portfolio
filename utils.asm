;; rdi    - buf
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

macro print fd, string
{
  mov rdi, string
  call strlen
  mov rdx, rax
  write fd, string, rdx
}

