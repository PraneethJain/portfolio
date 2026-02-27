format ELF64 executable

MAX_REQ_LEN equ 1024 * 64

include "syscalls.asm"
include "pfp.asm"

segment readable executable

include "utils.asm"

entry main
main:
  print STDOUT, socket_info
  socket AF_INET, SOCK_STREAM, 0
  mov [server_fd], rax
  cmp rax, 0
  jl fatal

  setsockopt [server_fd], SOL_SOCKET, SO_REUSEADDR, enable, 4
  cmp rax, 0
  jl fatal

  setsockopt [server_fd], SOL_SOCKET, SO_REUSEPORT, enable, 4
  cmp rax, 0
  jl fatal

  mov [serveraddr_in.sin_family], word AF_INET
  mov [serveraddr_in.sin_addr], dword 0
  mov ax, [port]
  xchg al, ah
  mov [serveraddr_in.sin_port], ax

  print STDOUT, binding_info
  bind [server_fd], serveraddr_in.sin_family, serveraddr_in.size
  cmp rax, 0
  jl fatal

  print STDOUT, listening_info
  listen [server_fd], MAX_BACKLOG
  cmp rax, 0
  jl fatal

  .mainloop:
    print STDOUT, accepting_info
    accept [server_fd], clientaddr_in, clientaddr_len
    mov [client_fd], rax 
    cmp rax, 0
    jl fatal

    read [client_fd], req, MAX_REQ_LEN
    mov  [req_len], rax
    cmp rax, 0
    jl fatal

    mov rdi, req
    call trim_first_line

    serve_route req, home
    serve_route req, projects
    serve_route req, about
    serve_route req, links
    
  .serve_not_found:
    print [client_fd], not_found_page_response
    print [client_fd], not_found_page
    close [client_fd]
    jmp .mainloop

  .serve_home:
    print [client_fd], found_page_response
    print [client_fd], index_page
    close [client_fd]
    jmp .mainloop

  .serve_projects:
    print [client_fd], found_page_response
    print [client_fd], projects_page
    close [client_fd]
    jmp .mainloop

  .serve_about:
    print [client_fd], found_page_response
    print [client_fd], about_page
    close [client_fd]
    jmp .mainloop
  
  .serve_links:
    print [client_fd], found_page_response
    print [client_fd], links_page
    close [client_fd]
    jmp .mainloop


  print STDOUT, closing_info
  close [server_fd]

  print STDOUT, done_info
  exit EXIT_SUCCESS

fatal:
  print STDERR, fatal_error
  close [client_fd]
  close [server_fd]
  exit EXIT_FAILURE

segment readable writable

struc servaddr_in_struc
{
  .sin_family dw 0
  .sin_port   dw 0
  .sin_addr   dd 0
  .sin_zero   dq 0
  .size = $ - .sin_family
}

;; variables
server_fd       dq -1
client_fd       dq -1
serveraddr_in   servaddr_in_struc
clientaddr_in   servaddr_in_struc
clientaddr_len  dd clientaddr_in.size
enable          dd 1
port            dw 8080

req             rb MAX_REQ_LEN
req_len         rq 1


;; debug messages
socket_info     db "[INFO] Creating Socket...", 10, 0
binding_info    db "[INFO] Binding Socket...", 10, 0
listening_info  db "[INFO] Listening...", 10, 0
accepting_info  db "[INFO] Accepting Connections...", 10, 0
closing_info    db "[INFO] Closing Socket...", 10, 0
done_info       db "[INFO] Done!", 10, 0
fatal_error     db "[ERROR] Fatal! Cannot Recover.", 10, 0

;; routes
home     db "", 0
about    db "about", 0
projects db "projects", 0
links    db "links", 0

;; responses
include "html.asm"

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
                        <div "font-size: 24px;", \
                           ! "Made in x86-64 Assembly: ", \
                           <link "https://github.com/praneethJain/portfolio", ! "source">, \
                        >
                     html_end

index_page_cgi       db 10
                     html_start "Praneeth Jain"
                     flexcol "min-width: 100vw; min-height: 100vh; align-items: center; justify-content: space-evenly; background-color: black; color: white;", \
                        <div "font-size: 60px; text-align: center;", ! "Moida Praneeth Jain">, \
                        pfp, \
                        <flexrow "font-size: 50px; min-width: max(40vw, 600px); justify-content: space-evenly;", \
                           <link "/projects.cgi", ! "/projects">, \
                           <link "/about.cgi", ! "/about">, \
                           <link "/links.cgi", ! "/links">, \
                        >, \
                        <div "font-size: 24px;", \
                           ! "Made in x86-64 Assembly: ", \
                           <link "https://github.com/praneethJain/portfolio", ! "source">, \
                        >
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
                           <about_item "Uptime:   ", "     21 years">, \
                           <about_item "Host:     ", "     IIIT Hyderabad, 4th year">, \
                           <about_item "Kernel:   ", "     Computer Science Engineering">, \
                           <about_item "Distro:   ", "     void">, \
                           <about_item "WM:       ", "     dwm">, \
                           <about_item "Editor:   ", "     (neo)vim">, \
                           <about_item "Terminal: ", "     st">, \
                           <about_item "Shell:    ", "     bash">, \
                        >, \
                     db 0
                     html_end

projects_page        db 10
                     html_start "Praneeth Jain | Projects"
                     flexcol "background-color: black; color: white; padding: 64px;", \
                        <project_category "projects", \
                           <project  "https://github.com/PraneethJain/simplipy", "SimpliPy", "A semantically simple interpreter for a core subset of Python3">, \
                           <project  "https://github.com/PraneethJain/wm", "Tiling WM", "A minimal window manager for X based on penrose">, \
                           <project  "https://github.com/PraneethJain/ardor", "Ardor", "A simple command line application to manage anime">, \
                           <project  "https://github.com/praneethJain/simply-black", "Simply Black", "Personalized VSCode theme with 1000+ downloads">, \
                           <project  "https://github.com/PraneethJain/pentagon-megathon", "Psyche-Screener", "Tool that emulates an interview screening process, used for personality based job classification">, \
                           <project  "https://github.com/PraneethJain/tra.sh", "tra.sh", "Linux shell utilizing OS system calls, with 0 memory allocated on the heap">, \
                           <project  "https://github.com/PraneethJain/nifty-file-storage-world", "Nifty File Storage", "Distributed file system with a client-server architecture using TCP sockets and multi-threading">, \
                           <project  "https://github.com/PraneethJain/simple_renderer", "Ray Tracer", "Renderer based on Physically Based Rendering, with support for multiple sampling methods">, \
                           <project  "https://github.com/praneethJain/citation-analysis", "Citation Analysis", "Community detection algorithms and centrality metrics for citation networks changing with time">, \
                           <project  "https://github.com/praneethJain/floodalert", "FloodAlert", "Cost effective IoT based flood monitoring system prototype">, \
                           <project  "https://github.com/PraneethJain/AutoVCO", "AutoVCO", "Neural Network based Adaptive Voltage Controlled Oscillator using Tensorflow and MicroCap12">, \
                           <project  "https://github.com/PraneethJain/Knowledge-Database", "Knowledge DB", "Database to store information about research, normalized to 3NF and implemented in MariaDB">, \
                        >, \
                        <project_category "webdev", \
                           <project  "https://github.com/PraneethJain/sonuscloud", "SonusCloud", "Internet Music Database, with functionality of viewing various artists, their albums and songs, review spotlighted artists, search on iTunes and favourite songs">, \
                           <project  "https://github.com/PraneethJain/IIITEats", "IIITEats", "Web app to crowd-source food delivery from canteens to hostels">, \
                           <project  "https://github.com/OSDG-IIITH/osdg-web", "OSDG Web", "Club website for the Open Source Developer's Group to display events and team members">, \
                           <project  "https://github.com/PraneethJain/TodoList", "To-Do List", "Manage tasks, categorize them into multiple lists, set deadlines, save to local storage">, \
                           <project  "https://github.com/PraneethJain/etch-a-sketch", "Etch a Sketch", "Canvas to draw ideas, with a resizable grid and color picker">, \
                        >, \
                        <project_category "gamedev", \
                           <project  "https://github.com/PraneethJain/PokemonType", "PokemonType", "Guess the Pokemon's type - Built using MERN stack">, \
                           <project  "https://github.com/PraneethJain/miredo", "MiReDo", "An interactive music game built within 24 hours on the theme - Reverse">, \
                           <project  "https://github.com/PraneethJain/HangerMan", "Hangerman", "Clone of the popular game Hangman">, \
                           <project  "https://github.com/PraneethJain/pong", "Pong", "Clone of Pong, with several improvements such as increasing difficulty, scoring system, and more">, \
                           <project  "https://github.com/PraneethJain/Chrome-Dinosaur-Game/", "Chrome Dinosaur Game", "Clone of the dinosaur game you play when internet is unavailable">, \
                           <project  "https://github.com/PraneethJain/Flappy-Melon/", "Flappy Melon", "Clone of Flappy Bird">, \
                           <project  "https://github.com/PraneethJain/tic-tac-toe", "Tic Tac Toe", "Simple local multiplayer tic-tac-toe in the browser">, \
                           <project  "https://github.com/PraneethJain/DASS/blob/main/Assignment-1/kaooa.py", "Kaooa Game", "Implementation of the classic strategy hunt game - kaooa">, \
                        >, \
                        <project_category "problemsolving", \
                           <project  "https://github.com/PraneethJain/Project-Euler", "Project Euler", "Solutions to the first hundred and a few other problems from Project Euler">, \
                           <project  "https://github.com/PraneethJain/Advent-of-Code-2022", "Advent of Code 2022", "Solutions to the first fourteen problems from AoC 2022">, \
                           <project  "https://github.com/PraneethJain/Advent-of-Code-2023", "Advent of Code 2023", "Solutions to all the problems from AoC 2023 in Rust">, \
                           <project  "https://github.com/PraneethJain/Advent-of-Code-2024", "Advent of Code 2024", "Solutions to a couple problems from AoC 2024 in Idris2">, \
                           <project  "https://github.com/PraneethJain/CSES/", "CSES", "Solutions to the cses.fi problemset">, \
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
