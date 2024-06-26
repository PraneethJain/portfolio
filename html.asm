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
db text, 10
}

macro h i, text
{
db '<h',i+'0','>',text,'</h',i+'0','>', 10
}

macro link href, component
{
db '<a href="',href,'" style="color: #3391ff">'
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
    div "font-size: 80px; font-weight: 600; color: var(--secondary); text-align: center;", ! category
    db '<div style="display: flex; flex-wrap: wrap; justify-content: center; align-items: center; margin: 64px 0; padding: 0 32px;">', 10
forward
    cards
common
    db '</div>', 10
}

macro project_card url, title, description, [tech_stack]
{
common
    db '<a href="', url, '" style="text-decoration: none; color: inherit;">', 10
    db '<div style="display: flex; flex-direction: column; justify-content: space-between; border: 4px dashed #808080; padding: 16px 0; text-align: center; width: 350px; height: 380px; margin: 32px;">', 10
    div "font-size: 40px; font-weight: 600; color: var(--primary)", ! title
    div "font-size: 24px; font-weight: 500; padding: 16px;", ! description
    db '<div style="display: flex; justify-content: space-evenly; font-size: 28px; flex-wrap: wrap; font-weight: 550;">'
forward
    div "", ! tech_stack
common
    db '</div>'
    db '</div>', 10
    db '</a>', 10
}

macro about_item left, right
{
    flexrow "", <div "color: var(--accent)", ! left>, <div "", ! right>
}
