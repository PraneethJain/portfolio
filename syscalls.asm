;; https://www.chromium.org/chromium-os/developer-library/reference/linux-constants/syscalls/

SYS_read        equ 0
SYS_write       equ 1
SYS_close       equ 3
SYS_socket      equ 41
SYS_accept      equ 43
SYS_bind        equ 49
SYS_listen      equ 50
SYS_setsockopt  equ 54
SYS_exit        equ 60
SYS_time        equ 201

SOCK_STREAM     equ 1
AF_INET         equ 2

STDIN           equ 0
STDOUT          equ 1
STDERR          equ 2

EXIT_SUCCESS    equ 0
EXIT_FAILURE    equ 1

MAX_BACKLOG     equ 16

SOL_SOCKET      equ 1
SO_REUSEADDR    equ 2
SO_REUSEPORT    equ 15

macro syscall1 nr, arg0
{
  mov rax, nr
  mov rdi, arg0
  syscall
}

macro syscall2 nr, arg0, arg1
{
  mov rax, nr
  mov rdi, arg0
  mov rsi, arg1
  syscall
}

macro syscall3 nr, arg0, arg1, arg2
{
  mov rax, nr
  mov rdi, arg0
  mov rsi, arg1
  mov rdx, arg2
  syscall
}

macro syscall4 nr, arg0, arg1, arg2, arg3
{
  mov rax, nr
  mov rdi, arg0
  mov rsi, arg1
  mov rdx, arg2
  mov r10, arg3
  syscall
}

macro syscall5 nr, arg0, arg1, arg2, arg3, arg4
{
  mov rax, nr
  mov rdi, arg0
  mov rsi, arg1
  mov rdx, arg2
  mov r10, arg3
  mov r8, arg4
  syscall
}

macro syscall6 nr, arg0, arg1, arg2, arg3, arg4, arg5
{
  mov rax, nr
  mov rdi, arg0
  mov rsi, arg1
  mov rdx, arg2
  mov r10, arg3
  mov r8, arg4
  mov r9, arg5
  syscall
}

macro exit code
{
  syscall1 SYS_exit, code
}

macro close fd
{
  syscall1 SYS_close, fd
}

macro time
{
  syscall1 SYS_time, 0
}

macro listen sockfd, backlog
{
  syscall2 SYS_listen, sockfd, backlog
}

macro read  fd, buf, count
{
  syscall3 SYS_read,  fd, buf, count
}

macro write fd, buf, count
{
  syscall3 SYS_write, fd, buf, count
}

macro socket socket_family, socket_type, protocol
{
  syscall3 SYS_socket, socket_family, socket_type, protocol
}

macro bind socket, address, address_len
{
  syscall3 SYS_bind, socket, address, address_len
}

macro accept socket, address, address_len
{
  syscall3 SYS_accept, socket, address, address_len
}

macro setsockopt fd, level, optname, optval, optlen
{
  syscall5 SYS_setsockopt, fd, level, optname, optval, optlen
}
