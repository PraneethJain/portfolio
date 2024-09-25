CRLF equ 13, 10

macro html_start title
{
db '<!doctype html>', 10
db '<html lang="en">', 10
db '  <head>', 10
db '    <meta charset="UTF-8" />', 10
db '    <title>',title,'</title>', 10
db '      <link rel="preconnect" href="https://fonts.googleapis.com">', 10
db '      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>', 10
db '      <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">', 10
db '      <link href="https://fonts.googleapis.com/css2?family=Pixelify+Sans:wght@400..700&display=swap" rel="stylesheet">'
db '      <link href="https://fonts.googleapis.com/css2?family=VT323&display=swap" rel="stylesheet">'
db '    <style>', 10
db '    :root {', 10
db '      --primary: #EADFB4;', 10
db '      --secondary: #DEAC80;', 10
db '      --accent: #B5C18E;', 10
db '    }', 10
db '    * {', 10
db '      margin: 0;', 10
db '      padding: 0;', 10
db '    }', 10
;
;; db '    @media only screen and (max-width: 768px) {', 10
;; db '      body {', 10
;; db '      transform: scale(1.5);', 10
;; db '      transform-origin: top;', 10
;; db '      }', 10
;; db '    }', 10
db '    </style>', 10
db '  </head>', 10
db '  <body style="padding: 0; margin: 0; font-family: VT323;">', 10
}

macro html_end
{
db '  </body>', 10
db '</html>', 10, 0
}

macro ! text
{
db text
}

macro h i, text
{
db '<h',i+'0','>',text,'</h',i+'0','>', 10
}

macro link href, component
{
db '<a href="',href,'" style="color: white">'
component
db '</a>', 10
}

macro div style, [components]
{
common db '<div style="',style,'">', 10
forward components
common db '</div>', 10
}

macro span style, [components]
{
common db '<span style="',style,'">', 10
forward components
common db '</span>', 10
}

macro pre style, [components]
{
common db '<pre style="',style,'">', 10
forward components
common db '</pre>', 10
}


macro flexcol style, [components]
{
common db '<div style="display: flex; flex-direction: column; ',style,'">', 10
forward components
common db '</div>', 10
}


macro flexrow style, [components]
{
common db '<div style="display: flex; flex-direction: row; ',style,'">', 10
forward components
common db '</div>', 10
}

macro project_category category, [cards]
{
common
    db '<div style="font-size: 64px; color: var(--secondary); margin: 32px 0 12px 0;">', 10
    ! "section ."#`category#" readable writable"
forward
    cards
common
    db '</div>', 10
}

macro project url, title, description
{
    div "font-size: 32px; margin: 0 0 12px 0; color: white;", <span "", ! "-" >, <link url, ! title>, <span "", ! ": "> ,<span "", ! description>
}

macro about_item left, right
{
    flexrow "", <div "color: var(--accent)", ! left>, <div "", ! right>
}
