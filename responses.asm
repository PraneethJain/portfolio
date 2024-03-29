index_page_response  db "HTTP/1.1 200 OK", 13, 10
                     db "Content-Type: text/html; charset=utf-8", 13, 10
                     db "Connection: close", 13, 10
                     db 13, 10
                     db 0

index_page_header    db "<h1>Hello from assembly!</h1>", 10
