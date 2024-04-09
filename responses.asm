include "html.asm"

index_page_response  db "HTTP/1.1 200 OK", CRLF
                     db "Content-Type: text/html; charset=utf-8", CRLF
                     db "Connection: close", CRLF
                     db CRLF
                     db 0

index_page           db 10
                     html_start "Praneeth Jain"
                     div "display: flex; width: 100%; align-items: center; justify-content: center;", \
                        ! "HELLO", \
                        ! "BYE"
                     html_end
