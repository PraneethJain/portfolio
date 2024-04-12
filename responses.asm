include "html.asm"
include "pfp.asm"

index_page_response  db "HTTP/1.1 200 OK", CRLF
                     db "Content-Type: text/html; charset=utf-8", CRLF
                     db "Connection: close", CRLF
                     db CRLF
                     db 0

index_page           db 10
                     html_start "Praneeth Jain"
                     div "display: flex; flex-direction: column; width: 100vw; height: 100vh; align-items: center; justify-content: center; background-color: black; color: white;", \
                        pfp, \
                        ! "HELLO", \
                        ! "BYE"
                     db 0
                     html_end
