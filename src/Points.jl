module Points

# Следющие имена должны быть публичными:
# Point, center, neighbors, Circle, Square

"Точка на декартовой плоскости."
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

"Круговая область."
Circle

"Квадратная область."
Square

"""
    center(points, area) -> Point

Центр масс точек `points`, принадлежащих области `area`.
"""
center(points, area)

end # module
