#=
Пример файла для экспериментов.

Запуск
1. Перейдите в директорию с пакетом (где Project.toml и этот файл)
2. Исполните скрипт с указанием окружения
   julia --project=Project.toml draft.jl
=#

using Points

@show Point(9, 10)
@show Point(9, 10) + Point(8, 4)
