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
                     flexcol "min-width: 100vw; min-height: 100vh; background-color: black; color: white; justify-content: center; align-items: center;", \
                        <project_category "Projects", \
                           <project_card "AutoVCO", "Neural Network based Adaptive Voltage Controlled Oscillator using Tensorflow and MicroCap12", "Tensorflow", "ESP32", "Python", "C++">, \
                           <project_card "Knowledge Database", "A database to store information about research, normalized to 3NF and implemented in MariaDB.", "Python", "SQL">, \
                           <project_card "Psyche-Screener", "A", "B">, \
                           <project_card "Ray Tracer", "A", "B">, \
                           <project_card "Citation Analysis", "A", "B">, \
                           <project_card "tra.sh", "A", "B">, \
                           <project_card "FloodAlert", "A", "B">, \
                           <project_card "Nifty File Storage", "A", "B">, \
                           <project_card "Ardor", "A", "B">, \
                           <project_card "Etch a Sketch", "A", "B">, \
                           <project_card "Simply Black", "A", "B">, \
                           <project_card "Hand Tracking", "A", "B">, \
                        >, \
                        <project_category "Web Development", \
                           <project_card "Calculator", "A", "B">, \
                           <project_card "IIITEats", "A", "B">, \
                           <project_card "SonusCloud", "A", "B">, \
                           <project_card "To-Do List", "A", "B">, \
                           <project_card "Tic Tac Toe", "A", "B">, \
                        >, \
                        <project_category "Games", \
                           <project_card "MiReDo", "A", "B">, \
                           <project_card "PokemonType", "A", "B">, \
                           <project_card "Hangerman", "A", "B">, \
                           <project_card "Pong", "A", "B">, \
                           <project_card "Flappy Melon", "A", "B">, \
                           <project_card "Chrome Dinosaur Game", "A", "B">, \
                           <project_card "Kaooa Game", "A", "B">, \
                        >, \
                        <project_category "Problem Solving", \
                           <project_card "Project Euler", "A", "B">, \ ; problem solving
                           <project_card "Advent of Code 2022", "A", "B">, \
                           <project_card "Advent of Code 2023", "A", "B">, \
                           <project_card "CSES", "A", "B">, \
                        >, \
                     db 0
                     html_end
