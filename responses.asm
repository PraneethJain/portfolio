include "html.asm"

index_page_response  db "HTTP/1.1 200 OK", CRLF
                     db "Content-Type: text/html; charset=utf-8", CRLF
                     db "Connection: close", CRLF
                     db CRLF
                     db 0

index_page           db 10
                     html_start "Nice Title"
                     h 1, "This is an h1"
                     h 2, "This is an h2"
                     h 3, "This is an h3"
                     h 4, "This is an h4"
                     h 5, "This is an h5"
                     html_end
