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
                        <flexrow "font-size: 24px; width: 30rem; justify-content: space-evenly;", \
                           <link "/projects", ! "/projects">, \
                           <link "/skills", ! "/skills">, \
                           <link "/about", ! "/about"> \
                        >, \
                        <flexrow "font-size: 24px; width: 20rem; justify-content: space-evenly;", \
                           <link "/resume", ! "/resume">, \
                           <link "/links", ! "/blog"> \
                        >, \
                     db 0
                     html_end

projects_page        db 10
                     html_start "Projects"
                     flexcol "min-width: 100vw; min-height: 100vh; background-color: black; color: white; justify-content: center; align-items: center;", \
                        <project_category "Projects", \
                           <project_card "Ardor", "A simple command line application to download, manage and watch currently airing anime.", "Python">, \
                           <project_card "Simply Black", "Personalized VSCode theme with 500+ downloads", "VSCode">, \
                           <project_card "Psyche-Screener", "Tool that emulates an interview screening process, with a full-stack web app and an android app, used for personality based classification", "Kotlin", "Python", "JavaScript">, \
                           <project_card "tra.sh", "Linux shell utilizing OS system calls, with 0 memory allocated on the heap", "C">, \
                           <project_card "Nifty File Storage", "Distributed file system with a client-server architecture using TCP sockets and multi-threading", "C">, \
                           <project_card "Ray Tracer", "Renderer based on Physically Based Rendering, with support for multiple sampling methods", "C++">, \
                           <project_card "Citation Analysis", "Community detection algorithms and centrality metrics for citation networks changing with time", "Rust">, \
                           <project_card "FloodAlert", "Cost effective IoT based flood monitoring system prototype", "ESP32", "OM2M", "C++">, \
                           <project_card "AutoVCO", "Neural Network based Adaptive Voltage Controlled Oscillator using Tensorflow and MicroCap12", "Tensorflow", "ESP32", "Python", "C++">, \
                           <project_card "Knowledge DB", "Database to store information about research, normalized to 3NF and implemented in MariaDB", "Python", "SQL">, \
                        >, \
                        <project_category "Web Development", \
                           <project_card "SonusCloud", "Internet Music Database, with functionality of viewing various artists, their albums and songs, review spotlighted artists, search on iTunes and favourite songs", "JavaScript", "Python", "Flask">, \
                           <project_card "IIITEats", "Web app to crowd-source food delivery from canteens to hostels", "JavaScript", "Python", "Flask">, \
                           <project_card "OSDG Web", "Club website for the Open Source Developer's Group to display events and team members", "TypeScript", "TailwindCSS", "NextJS">, \
                           <project_card "To-Do List", "Manage tasks, categorize them into multiple lists, set deadlines, save to local storage", "HTML", "CSS", "JavaScript", "Webpack">, \
                           <project_card "Etch a Sketch", "Canvas to draw ideas, with a resizable grid and color picker", "HTML", "CSS", "JavaScript">, \
                        >, \
                        <project_category "Games", \
                           <project_card "PokemonType", "Guess the Pokemon's type - Built using MERN stack", "ReactJS", "MongoDB", "ExpressJS">, \
                           <project_card "MiReDo", "An interactive music game built within 24 hours on the theme - Reverse", "HTML", "CSS", "JavaScript">, \
                           <project_card "Hangerman", "Clone of the popular game Hangman", "Pygame">, \
                           <project_card "Pong", "Clone of Pong, with several improvements such as increasing difficulty, scoring system, and more", "Pygame">, \
                           <project_card "Chrome Dinosaur Game", "Clone of the dinosaur game you play when internet is unavailable", "Pygame">, \
                           <project_card "Flappy Melon", "Clone of Flappy Bird", "Pygame">, \
                           <project_card "Tic Tac Toe", "Simple local multiplayer tic-tac-toe in the browser", "HTML", "CSS", "JavaScript">, \
                           <project_card "Kaooa Game", "Implementation of the classic strategy hunt game - kaooa", "Ursina">, \
                        >, \
                        <project_category "Problem Solving", \
                           <project_card "Project Euler", "Solutions to the first hundred and a few other problems from Project Euler", "Python", "Julia", "C", "C++">, \
                           <project_card "Advent of Code 2022", "Solutions to the first fourteen problems from AoC 2022", "Python", "C#", "Julia">, \
                           <project_card "Advent of Code 2023", "Solutions to all the problems from AoC 2023", "Rust">, \
                           <project_card "CSES", "Solutions to the cses.fi problemset", "C++">, \
                        >, \
                     db 0
                     html_end
