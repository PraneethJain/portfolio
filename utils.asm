macro print_char fd, char
{
  push char
  write fd, rsp, 1
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

;; Checks if the route string corresponds to the request string
;; rdi    - request string
;; rsi    - route string
;; retval - rax
check_route:
  add rdi, 5
  .routecheckloop:
    cmp byte [rdi], 32
    je .routechecksuccess

    mov al, byte [rdi]
    mov bl, byte [rsi]
    cmp al, bl
    jne .routecheckfailure

    inc rdi
    inc rsi
    
    jmp .routecheckloop

  .routechecksuccess:
    mov rax, 1
    ret

  .routecheckfailure:
    mov rax, 0
    ret


macro serve_route req, route
{
  mov rdi, req
  mov rsi, route
  call check_route
  cmp rax, 0
  jne .serve_#route
}
