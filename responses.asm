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
                        <div "font-size: 60px; text-align: center;", ! "Moida Praneeth Jain">, \
                        pfp, \
                        <flexrow "font-size: 50px; min-width: max(40vw, 600px); justify-content: space-evenly;", \
                           <link "/projects", ! "/projects">, \
                           <link "/about", ! "/about">, \
                           <link "/links", ! "/links">, \
                        >, \
                        <div "font-size: 24px;", ! "Made in x86-64 Assembly", <link "https://github.com/praneethJain/portfolio", ! "source">>, \
                     db 0
                     html_end

links_page           db 10
                     html_start "Praneeth Jain | Links"
                     flexcol "min-width: 100vw; min-height: 100vh; align-items: center; justify-content: center; background-color: black; color: white; font-size: 50px;", \
                        <link "https://github.com/PraneethJain/", ! "Github">, \
                        <link "https://gitlab.com/PraneethJain", ! "Gitlab">, \
                        <link "https://stackoverflow.com/users/18171521/praneeth-jain", ! "StackOverflow">, \
                        <link "https://www.linkedin.com/in/praneeth-jain/", ! "LinkedIn">, \
                        <link "mailto:praneethjain005@gmail.com", ! "Mail">, \
                        <link "https://discord.com/users/478215148234866728", ! "Discord">, \
                        <link "https://steamcommunity.com/profiles/76561198879507582", ! "Steam">, \
                        <link "https://www.instagram.com/mpraneethjain/", ! "Instagram">, \
                        <link "https://www.facebook.com/profile.php?id=100087488941910", ! "Facebook">, \
                        <link "https://x.com/bants78", ! "X">, \
                     db 0
                     html_end

about_page           db 10
                     html_start "Praneeth Jain | About"
                     flexcol "min-width: 100vw; min-height: 100vh; align-items: center; justify-content: center; background-color: black; color: white; font-size: 50px;", \
                        <pre "font-family: vt323; font-size: 50px; line-height: 15px;", \
                           <about_item "Uptime:   ", "     19 years">, \
                           <about_item "Host:     ", "     IIIT Hyderabad, 3rd year">, \
                           <about_item "Kernel:   ", "     Computer Science Engineering">, \
                           <about_item "Distro:   ", "     arch     / void">, \
                           <about_item "WM:       ", "     hyprland / dwm">, \
                           <about_item "IDE:      ", "     emacs    / helix">, \
                           <about_item "Terminal: ", "     kitty    / st">, \
                           <about_item "Shell:    ", "     fish      / bash">, \
                        >, \
                     db 0
                     html_end

projects_page        db 10
                     html_start "Praneeth Jain | Projects"
                     flexcol "min-width: 100vw; min-height: 100vh; background-color: black; color: white; justify-content: center; align-items: center;", \
                        <project_category "Projects", \
                           <project_card  "https://github.com/PraneethJain/ardor", "Ardor", "A simple command line application to download, manage and watch currently airing anime.", "Python">, \
                           <project_card  "https://github.com/praneethJain/simply-black", "Simply Black", "Personalized VSCode theme with 500+ downloads", "VSCode">, \
                           <project_card  "https://github.com/PraneethJain/pentagon-megathon", "Psyche-Screener", "Tool that emulates an interview screening process, with a full-stack web app and an android app, used for personality based classification", "Kotlin", "Python", "JavaScript">, \
                           <project_card  "https://github.com/PraneethJain/tra.sh", "tra.sh", "Linux shell utilizing OS system calls, with 0 memory allocated on the heap", "C">, \
                           <project_card  "https://github.com/PraneethJain/nifty-file-storage-world", "Nifty File Storage", "Distributed file system with a client-server architecture using TCP sockets and multi-threading", "C">, \
                           <project_card  "https://github.com/PraneethJain/simple_renderer", "Ray Tracer", "Renderer based on Physically Based Rendering, with support for multiple sampling methods", "C++">, \
                           <project_card  "https://github.com/praneethJain/citation-analysis", "Citation Analysis", "Community detection algorithms and centrality metrics for citation networks changing with time", "Rust">, \
                           <project_card  "https://github.com/praneethJain/floodalert", "FloodAlert", "Cost effective IoT based flood monitoring system prototype", "ESP32", "OM2M", "C++">, \
                           <project_card  "https://github.com/PraneethJain/AutoVCO", "AutoVCO", "Neural Network based Adaptive Voltage Controlled Oscillator using Tensorflow and MicroCap12", "Tensorflow", "ESP32", "Python", "C++">, \
                           <project_card  "https://github.com/PraneethJain/Knowledge-Database", "Knowledge DB", "Database to store information about research, normalized to 3NF and implemented in MariaDB", "Python", "SQL">, \
                        >, \
                        <project_category "Web Development", \
                           <project_card  "https://github.com/PraneethJain/sonuscloud", "SonusCloud", "Internet Music Database, with functionality of viewing various artists, their albums and songs, review spotlighted artists, search on iTunes and favourite songs", "JavaScript", "Python", "Flask">, \
                           <project_card  "https://github.com/PraneethJain/IIITEats", "IIITEats", "Web app to crowd-source food delivery from canteens to hostels", "JavaScript", "Python", "Flask">, \
                           <project_card  "https://github.com/OSDG-IIITH/osdg-web", "OSDG Web", "Club website for the Open Source Developer's Group to display events and team members", "TypeScript", "TailwindCSS", "NextJS">, \
                           <project_card  "https://github.com/PraneethJain/TodoList", "To-Do List", "Manage tasks, categorize them into multiple lists, set deadlines, save to local storage", "HTML", "CSS", "JavaScript", "Webpack">, \
                           <project_card  "https://github.com/PraneethJain/etch-a-sketch", "Etch a Sketch", "Canvas to draw ideas, with a resizable grid and color picker", "HTML", "CSS", "JavaScript">, \
                        >, \
                        <project_category "Games", \
                           <project_card  "https://github.com/PraneethJain/PokemonType", "PokemonType", "Guess the Pokemon's type - Built using MERN stack", "ReactJS", "MongoDB", "ExpressJS">, \
                           <project_card  "https://github.com/PraneethJain/miredo", "MiReDo", "An interactive music game built within 24 hours on the theme - Reverse", "HTML", "CSS", "JavaScript">, \
                           <project_card  "https://github.com/PraneethJain/HangerMan", "Hangerman", "Clone of the popular game Hangman", "Pygame">, \
                           <project_card  "https://github.com/PraneethJain/pong", "Pong", "Clone of Pong, with several improvements such as increasing difficulty, scoring system, and more", "Pygame">, \
                           <project_card  "https://github.com/PraneethJain/Chrome-Dinosaur-Game/", "Chrome Dinosaur Game", "Clone of the dinosaur game you play when internet is unavailable", "Pygame">, \
                           <project_card  "https://github.com/PraneethJain/Flappy-Melon/", "Flappy Melon", "Clone of Flappy Bird", "Pygame">, \
                           <project_card  "https://github.com/PraneethJain/tic-tac-toe", "Tic Tac Toe", "Simple local multiplayer tic-tac-toe in the browser", "HTML", "CSS", "JavaScript">, \
                           <project_card  "https://github.com/PraneethJain/DASS/blob/main/Assignment-1/kaooa.py", "Kaooa Game", "Implementation of the classic strategy hunt game - kaooa", "Ursina">, \
                        >, \
                        <project_category "Problem Solving", \
                           <project_card  "https://github.com/PraneethJain/Project-Euler", "Project Euler", "Solutions to the first hundred and a few other problems from Project Euler", "Python", "Julia", "C", "C++">, \
                           <project_card  "https://github.com/PraneethJain/Advent-of-Code-2022", "Advent of Code 2022", "Solutions to the first fourteen problems from AoC 2022", "Python", "C#", "Julia">, \
                           <project_card  "https://github.com/PraneethJain/Advent-of-Code-2023", "Advent of Code 2023", "Solutions to all the problems from AoC 2023", "Rust">, \
                           <project_card  "https://github.com/PraneethJain/CSES/", "CSES", "Solutions to the cses.fi problemset", "C++">, \
                        >, \
                     db 0
                     html_end

not_found_page_response db "HTTP/1.1 404 Not Found", CRLF
                        db "Content-Type: text/html; charset=utf-8", CRLF
                        db "Connection: close", CRLF
                        db CRLF
                        db 0


not_found_page       db 10
                     html_start "Praneeth Jain"
                     flexcol "min-width: 100vw; min-height: 100vh; align-items: center; justify-content: center; background-color: black; color: white; text-align: centre;", \
                        <div "font-size: 3.3rem;", ! "How Did We Get Here?">, \
                        <link "/", <h 1,"Go Back">>, \
                     db 0
                     html_end
