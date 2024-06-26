format ELF64 executable

segment readable executable

include "syscalls.asm"
include "utils.asm"

entry main
main:
    print STDOUT, found_page_response
    print STDOUT, about_page

segment readable writable

include "responses.asm"
