include "html.asm"
include "pfp.asm"

found_page_response  db "HTTP/1.1 200 OK", CRLF
                     db "Content-Type: text/html; charset=utf-8", CRLF
                     db "Connection: close", CRLF
                     db CRLF
                     db 0

index_page           db 10
                     html_start "Praneeth Jain"
                     flexcol "min-width: 100vw; min-height: 100vh; align-items: center; justify-content: space-evenly; background-color: black; color: white;", \
                        <h 1, "Moida Praneeth Jain">, \
                        pfp, \
                        <flexrow "font-size: 24px; width: 40%; justify-content: space-evenly;", \
                           <link "/projects", ! "/projects">, \
                           <link "/skills", ! "/skills">, \
                           <link "/about", ! "/about"> \
                        >, \
                        <flexrow "font-size: 24px; width: 30%; justify-content: space-evenly;", \
                           <link "/d", ! "/d">, \
                           <link "/e", ! "/e"> \
                        >, \
                     db 0
                     html_end

projects_page        db 10
                     html_start "Projects"
                     flexrow "min-width: 100vw; min-height: 100vh; align-items: center; justify-content: space-evenly; background-color: black; color: white;", \
                        <project_card "AutoVCO", "ML-Driven Adaptive Voltage Controlled Oscillator", "Tensorflow", "ESP32", "Python", "C++">, \
                     db 0
                     html_end
