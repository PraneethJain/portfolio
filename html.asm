CRLF equ 13, 10

macro html_start title
{
db '<!doctype html>', 10
db '<html lang="en">', 10
db '  <head>', 10
db '    <meta charset="UTF-8" />', 10
db '    <title>',title,'</title>', 10
db '  </head>', 10
db '  <body style="padding: 0; margin: 0; font-family: monospace;">', 10
}

macro html_end
{
db '  </body>', 10
db '</html>', 10
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

macro project_card title, description, [tech_stack]
{

common
    db '<div style="display: flex; flex-direction: column; justify-content: space-between;border: 2px dashed white; padding: 1rem 0; text-align: center; width: 20rem; height: 20rem;">', 10
    h 1, title
    div "font-size: 1rem;", ! description
    db '<div style="display: flex; justify-content: space-evenly; font-size: 1rem; flex-wrap: wrap;">'
forward
    div "", ! tech_stack
common
    db '</div>'
    db '</div>', 10
}
