format ELF64 executable

include "syscalls.asm"

segment readable executable

include "utils.asm"

entry main
main:
  print hello
  exit 0

segment readable writable

hello db "BananaPants87", 10, 0
