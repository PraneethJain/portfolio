format ELF64 executable

MAX_REQ_LEN equ 1024 * 64

include "syscalls.asm"

segment readable executable

include "utils.asm"

entry main
main:
  print STDOUT, socket_info
  socket AF_INET, SOCK_STREAM, 0
  mov [server_fd], rax
  cmp rax, 0
  jl fatal

  setsockopt [server_fd], SOL_SOCKET, SO_REUSEADDR, enable, 4
  cmp rax, 0
  jl fatal

  setsockopt [server_fd], SOL_SOCKET, SO_REUSEPORT, enable, 4
  cmp rax, 0
  jl fatal

  mov [serveraddr_in.sin_family], word AF_INET
  mov [serveraddr_in.sin_addr], dword 0
  mov [serveraddr_in.sin_port], word 36895

  print STDOUT, binding_info
  bind [server_fd], serveraddr_in.sin_family, serveraddr_in.size
  cmp rax, 0
  jl fatal

  print STDOUT, listening_info
  listen [server_fd], MAX_BACKLOG
  cmp rax, 0
  jl fatal

  .mainloop:
    print STDOUT, accepting_info
    accept [server_fd], clientaddr_in, clientaddr_len
    mov [client_fd], rax 
    cmp rax, 0
    jl fatal

    read [client_fd], req, MAX_REQ_LEN
    mov  [req_len], rax
    cmp rax, 0
    jl fatal

    mov rdi, req
    call trim_first_line

    mov rdi, req
    mov rsi, home_route
    call check_route
    cmp rax, 0
    jne .serve_home_route
    
    ; check_route req, about_route
    ; cmp rax, 0
    ; jne .serve_about_page

    ; check_route req, projects_route
    ; cmp rax, 0
    ; jne .serve_projects_page

    ; check_route req, skills_route
    ; cmp rax, 0
    ; jne .serve_skills_page

  .serve_not_found:
    print_char STDOUT, 'N'
    print_char STDOUT, 10
    print [client_fd], index_page_response
    print [client_fd], index_page
    close [client_fd]
    jmp .mainloop

  .serve_home_route:
    print_char STDOUT, 'H'
    print_char STDOUT, 10
    print [client_fd], index_page_response
    print [client_fd], index_page
    close [client_fd]
    jmp .mainloop

  .serve_about_page:   
    print_char STDOUT, 'A'
    print_char STDOUT, 10
    print [client_fd], index_page_response
    print [client_fd], index_page
    close [client_fd]
    jmp .mainloop
  
  .serve_projects_page:   
    print_char STDOUT, 'P'
    print_char STDOUT, 10
    print [client_fd], index_page_response
    print [client_fd], index_page
    close [client_fd]
    jmp .mainloop

  .serve_skills_page:   
    print_char STDOUT, 'S'
    print_char STDOUT, 10
    print [client_fd], index_page_response
    print [client_fd], index_page
    close [client_fd]
    jmp .mainloop

  print STDOUT, closing_info
  close [server_fd]

  print STDOUT, done_info
  exit EXIT_SUCCESS

fatal:
  print STDERR, fatal_error
  close [client_fd]
  close [server_fd]
  exit EXIT_FAILURE

segment readable writable

include "responses.asm"

struc servaddr_in_struc
{
  .sin_family dw 0
  .sin_port   dw 0
  .sin_addr   dd 0
  .sin_zero   dq 0
  .size = $ - .sin_family
}

;; variables
server_fd       dq -1
client_fd       dq -1
serveraddr_in   servaddr_in_struc
clientaddr_in   servaddr_in_struc
clientaddr_len  dd clientaddr_in.size
enable          dd 1

req             rb MAX_REQ_LEN
req_len         rq 1


;; debug messages
socket_info     db "[INFO] Creating Socket...", 10, 0
binding_info    db "[INFO] Binding Socket...", 10, 0
listening_info  db "[INFO] Listening...", 10, 0
accepting_info  db "[INFO] Accepting Connections...", 10, 0
closing_info    db "[INFO] Closing Socket...", 10, 0
done_info       db "[INFO] Done!", 10, 0
fatal_error     db "[ERROR] Fatal! Cannot Recover.", 10, 0
message         db "Hello from fasm!", 10, 0

;; routes
home_route      db "/", 0
about_route     db "/about", 0
projects_route  db "/projects", 0
skills_route    db "/skills", 0
