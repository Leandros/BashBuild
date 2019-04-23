#ifndef WIDGET_HPP
#define WIDGET_HPP
#pragma once

class Widget
{
public:
    static Widget
    Create(int x, int y);

    void
    DebugPrint() const;

private:
    Widget(int x, int y)
        : _x(x)
        , _y(y)
    {}

    int _x, _y;
};


#endif /* WIDGET_HPP */

