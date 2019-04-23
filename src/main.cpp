#include <widget.hpp>
#include <stdio.h>

int
main()
{
    Widget btn = Widget::Create(10, 30);
    btn.DebugPrint();
    puts("");
    return 0;
}

