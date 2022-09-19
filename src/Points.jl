module Points

import LinearAlgebra

export dist
export center
export neighbors
export Point
export Circle
export Square

# Следющие имена должны быть публичными:
# Point, neighbors, Circle, Square, center

"""
    Point(x, y)

Точка на декартовой плоскости.
"""
struct Point{T1<:Real, T2<:Real}
    x::T1
    y::T2
end

dist(p::Point) = sqrt(p.x^2 + p.y^2)
random_point() = Point(rand(2)...)

LinearAlgebra.norm(p::Point) = dist(p)
LinearAlgebra.dot(p1::Point, p2::Point) = p1.x * p2.x + p1.y * p2.y

Base.:+(p1::Point, p2::Point) = Point(p1.x + p2.x, p1.y + p2.y)
Base.:-(p1::Point, p2::Point) = Point(p1.x - p2.x, p1.y - p2.y)
Base.:-(p::Point) = Point(-p.x,-p.y)
Base.:*(α::Number, p::Point) = Point(α * p.x, α * p.y)
Base.:*(p::Point, α::Number) = α * p
Base.:/(p::Point, α::Number) = p * (1/α)

"""
    center(points) -> Point

Центр "масс" точек.
"""
function center(points)
	N = length(points)
	a=[Point(0,0) for i in 1:N]
	a[1] = points[1]
	if N > 1
		for i in 2:N
			a[i]=a[i-1] + points[i]
		end
	end
	return a[end]/N
end

"""
    neighbors(points, origin, k) -> Vector{Point}

Поиск ближайших `k` соседей точки `origin` среди точек `points`.
"""
function neighbors(points, origin, k::Int)
	if k<=0
		return []
	end
	rho = [dist(p-origin) for p in points]
	
	D = Dict{Point, Real}
	for i in 1:length(points)
    	D[points[i]] = rho[i]
    end
	sort(collect(D), by=x->x[2])
	
	return isapprox(sort(collect(D), by=x->x[2])[1][2] == 0.0) ? sort(collect(D), by=x->x[2])[2][1] : sort(collect(D), by=x->x[2])[1][1] == 0.0
end

"""
    Circle(o::Point, radius)

Круг с центром `o` и радиусом `radius`.
"""
struct Circle{TO<:Point, TR<:Real}
	o::TO
	radius::TR
end

Base.:in(p::Point, c::Circle) = dist(p-c.o) <= c.radius

"""
    Square(o::Point, side)

Квадрат с центром в `o` и стороной `side`. Стороны квадрата параллельны осям координат.
"""
struct Square{TO<:Point, TS<:Real}
	o::TO
	side::TS
end

Base.:in(p::Point, s::Square) = abs((s.o).x-p.x) <= s.side/2 && abs((s.o).y-p.y) <= s.side/2

"""
    center(points, area) -> Point

Центр масс точек `points`, принадлежащих области `area` (`Circle` или `Square`).	
"""
function center(points, area)
	N = length(points)
	internal = []
	for p in points
		if p in area
			push!(internal, p)
		end
	end
	return center(internal)
end

end # module
