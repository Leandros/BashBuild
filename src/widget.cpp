#include <widget.hpp>

#include <stdio.h>

Widget
Widget::Create(int x, int y)
{
    return Widget{ x, y };
}

void
Widget::DebugPrint() const
{
    printf("Widget{ .x = %d, .y = %d }", _x, _y);
}

