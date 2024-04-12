include "html.asm"
include "pfp.asm"

index_page_response  db "HTTP/1.1 200 OK", CRLF
                     db "Content-Type: text/html; charset=utf-8", CRLF
                     db "Connection: close", CRLF
                     db CRLF
                     db 0

index_page           db 10
                     html_start "Praneeth Jain"
                     flexcol "width: 100vw; height: 100vh; align-items: center; justify-content: space-evenly; background-color: black; color: white;", \
                        <h 1, "Moida Praneeth Jain">, \
                        pfp, \
                        <flexrow "font-size: 24px; width: 40%; justify-content: space-evenly;", \
                           <link "/a", ! "/a">, \
                           <link "/b", ! "/b">, \
                           <link "/c", ! "/c"> \
                        >, \
                        <flexrow "font-size: 24px; width: 30%; justify-content: space-evenly;", \
                           <link "/d", ! "/d">, \
                           <link "/e", ! "/e"> \
                        >, \
                     db 0
                     html_end
