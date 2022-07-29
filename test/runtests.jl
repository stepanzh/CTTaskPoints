using Test
using Points
import LinearAlgebra

@testset "Points.jl" begin

@testset "Линейные операции" begin
    p₁ = Point(1, 2)
    p₂ = Point(4, 5)
    @testset "Сложение (+)" begin @test p₁ + p₂ == Point(5, 7) end
    @testset "Вычитание (-)" begin
        @test p₁ - p₂ == Point(-3, -3)
        @test p₂ - p₁ == Point(3, 3)
    end
    @testset "Обратный элемент (-)" begin @test -p₁ == Point(-1, -2) end
    @testset "Умножение на скаляр (*)" begin
        @test 2.5 * p₁ == Point(2.5, 5.0)
        @test p₁ * 2.5 == Point(2.5, 5.0)
        @test -2.5 * p₁ == Point(-2.5, -5.0)
    end
    @testset "Деление на скаляр (/)" begin @test p₁ / 2 == Point(0.5, 1.0) end
end

@testset "Линейная алгебра" begin
    @testset "Норма" begin @test LinearAlgebra.norm(Point(1, 1)) ≈ √2 end
    @testset "Скалярное произведение" begin
        @test LinearAlgebra.dot(Point(1, 2), Point(2, 3)) == 8
    end
end

@testset "Точка в круге" begin
    @test Point(1, 1) in Circle(Point(0, 0), 2)
    @test Point(1, 0) in Circle(Point(2.0, 0.0), nextfloat(1.0))
end

@testset "Точка в квадрате" begin
    @test Point(1, 1) in Square(Point(0, 0), 2)
    @test !(Point(1, 1) in Square(Point(2.0, 2.0), prevfloat(2.0)))
end

@testset "Центр \"масс\" (center)" begin
    @testset "Центр точек без области" begin center(i * Point(1, 1) for i in 1:10) == Point(5.5, 5.5) end

    points = [Point(x, y) for x in -2:2, y in -2:2]
    @testset "Центр точек, лежащих в круге" begin
        @test center(points, Circle(Point(1, 2), 1)) == Point(1.0, 1.75)
    end

    @testset "Центр точек, лежащих в квадрате" begin
        s = Square(Point(0, 0) + Point(0.5, 0.5), 2.0)
        @test center(points, s) == Point(0.5, 0.5)
    end
end

@testset "k-Ближайших соседей" begin
    points = [Point(x, y) for x in -2:2, y in -2:2]
    origin = points[3, 3]

    @test isempty(neighbors(points, origin, 0))
    @test isempty(neighbors(points, origin, -1))

    n4 = Set(Point(x, y) for x in -1:1, y in -1:1 if  abs(x + y) == 1)
    @test first(neighbors(points, origin, 1)) in n4
    @test all(x -> x in n4, neighbors(points, origin, 4))

    @test all(x -> x in setdiff(Set(points[2:4, 2:4]), [origin]), neighbors(points, origin, 8))
    @test Set(neighbors(points, origin, 2 * length(points))) == setdiff(Set(points), [origin])
end

@testset "Дополнительно" begin
    @testset "Конструкторы типов" begin
        @testset "Point" begin
            @test Point(1, 1.0) isa Point
            @test Point(1 + 1im, 2.0 + 1.0im) isa Point
        end
        @testset "Circle" begin
            @test Circle(Point(1, 1.0), 2) isa Circle
            @test Circle(Point(1 + 1im, 2.0 + 1.0im), 2) isa Circle
        end
    end
    @testset "Стабильность типов" begin
        points = [Point(x, y) for x in -2:2, y in -2:2]
        origin = points[3, 3]

        @testset "k-Ближайших соседей" for k in 1:length(points)+1
            @inferred neighbors(points, origin, k)
        end

        @testset "Центр точек, лежащих в круге" begin
            @inferred center(points, Circle(Point(1, 2), 1))
        end

        @testset "Центр точек, лежащих в квадрате" begin
            s = Square(Point(0, 0) + Point(0.5, 0.5), 2.0)
            @inferred center(points, s)
        end
    end
end

end # @testest
