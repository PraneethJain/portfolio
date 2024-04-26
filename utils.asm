macro print_char char
{
  push char
  write STDOUT, rsp, 1
  add rsp, 8
}

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

;; Replace the first carriage return with a terminating zero
;; rdi    - buf
trim_first_line:
  .loop:
    cmp byte [rdi], 13
    je .found
    inc rdi
    jmp .loop

  .found:
    mov byte [rdi], 0
    ret


macro print fd, string
{
  mov rdi, string
  call strlen
  mov rdx, rax
  write fd, string, rdx
}


macro check_route req, route
{
  mov rdi, req

  call trim_first_line
  mov r9, rax

  print STDOUT, req
  print_char 10
}
