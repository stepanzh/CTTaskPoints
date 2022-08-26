module Points

# Следющие имена должны быть публичными:
# Point, neighbors, Circle, Square, center

"""
    Point(x, y)

Точка на декартовой плоскости.
"""
Point

"""
    center(points) -> Point

Центр "масс" точек.
"""
center(points)

"""
    neighbors(points, origin, k) -> Vector{Point}

Поиск ближайших `k` соседей точки `origin` среди точек `points`.
"""
neighbors(points, origin, k)

"""
    Circle(o::Point, radius)

Круг с центром `o` и радиусом `radius`.
"""
Circle

"""
    Square(o::Point, side)

Квадрат с центром в `o` и стороной `side`.
"""
Square

"""
    center(points, area) -> Point

Центр масс точек `points`, принадлежащих области `area` (`Circle` или `Square`).
"""
center(points, area)

end # module
