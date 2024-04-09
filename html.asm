CRLF equ 13, 10

macro html_start title
{
db '<!doctype html>', 10
db '<html lang="en">', 10
db '  <head>', 10
db '    <meta charset="UTF-8" />', 10
db '    <title>',title,'</title>', 10
db '  </head>', 10
db '  <body style="padding: 0; margin: 0;">', 10
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
db '<a href="',href,'">'
component
db '</a>', 10
}

macro div style, [components]
{
common db '<div style="',style,'">', 10
forward components
common db '</div>', 10
}
