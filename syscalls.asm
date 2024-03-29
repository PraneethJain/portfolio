;; https://www.chromium.org/chromium-os/developer-library/reference/linux-constants/syscalls/

SYS_write equ 1
SYS_exit equ 60

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

macro write fd, buf, count
{
  syscall3 SYS_write, fd, buf, count
}
