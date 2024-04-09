CRLF equ 13, 10

macro html_start title
{
db '<!doctype html>', 10
db '<html lang="en">', 10
db '  <head>', 10
db '    <meta charset="UTF-8" />', 10
db '    <title>',title,'</title>', 10
db '  </head>', 10
db '  <body>', 10
}

macro html_end
{
db '  </body>', 10
db '</html>', 10
}

