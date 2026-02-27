macro print_char fd, char
{
  push char
  write fd, rsp, 1
  add rsp, 8
}

populate_age:
  time                   ;; syscall to get current time
  mov rdi, 1105401600    ;; aproximate date of birth
  sub rax, rdi
  mov rdi, rax
  mov rsi, age_value
  call int_to_str
  ret

;; Convert integer into a string and puts it in the provided buffer
;; rdi	  - int
;; rsi    - buffer to fill
int_to_str:
  mov rax, rdi
  xor rcx, rcx
  mov r8, 10
  .int_to_str_loop:
    xor rdx, rdx
	div r8   ; rax = rax / 10, rdx = remainder
	add dl, '0'
	push rdx
	inc rcx
	cmp rax, 0
	jne .int_to_str_loop

  .write_loop:
    cmp rcx, 0
	je .done
	pop rdx
	mov byte [rsi], dl
	inc rsi
	dec rcx
	jmp .write_loop

  .done:
	mov byte [rsi], 0
    ret

;; rdi    - buf
;; retval - rax
strlen:
  xor rax, rax
  push rdi

  .strlenloop:
    cmp byte [rdi], 0
    je .strlenret
    inc rdi
    inc rax
    jmp .strlenloop

  .strlenret:
	pop rdi
    ret

;; Returns prefix length if pattern matches start of text, else 0
;; rdi    - text
;; rsi    - pattern
;; retval - rax
str_prefix_len:
  xor rax, rax
  .loop:
    mov dl, byte [rsi + rax]
    cmp dl, 0
    je .match

    cmp byte [rdi + rax], dl
    jne .no_match

    inc rax
    jmp .loop

  .match:
    ret

  .no_match:
    xor rax, rax
    ret

;; Render template into output buffer with key/value replacements.
;; rdi    - template string
;; rsi    - output buffer
;; rdx    - template variable table
;; rcx    - table entry count
render_template:
  mov r8, rdi
  mov r9, rsi
  mov r10, rdx
  mov r11, rcx

  .scan:
    mov al, byte [r8]
    cmp al, 0
    je .done

    cmp al, '{'
    jne .copy_char
    cmp byte [r8 + 1], '{'
    jne .copy_char

    mov r12, r10
    mov r13, r11

  .try_keys:
    cmp r13, 0
    je .copy_char

    mov rdi, r8
    mov rsi, [r12]
    call str_prefix_len
    cmp rax, 0
    je .next_key

    add r8, rax
    mov r14, [r12 + 8]

  .copy_value:
    mov al, byte [r14]
    cmp al, 0
    je .scan

    mov byte [r9], al
    inc r9
    inc r14
    jmp .copy_value

  .next_key:
    add r12, 16
    dec r13
    jmp .try_keys

  .copy_char:
    mov al, byte [r8]
    mov byte [r9], al
    inc r8
    inc r9
    jmp .scan

  .done:
    mov byte [r9], 0
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
    je .routecheckintermediate

    mov al, byte [rdi]
    mov bl, byte [rsi]
    cmp al, bl
    jne .routecheckfailure

    inc rdi
    inc rsi
    
    jmp .routecheckloop

  .routecheckintermediate:
    cmp byte [rsi], 0
    je .routechecksuccess
    jne .routecheckfailure

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
