using DifferentialEquations
using Plots

M10 = 5.4
M20 = 5.1

pcr = 27.0
N = 30.0
q = 1.0

tau1 = 8.0
tau2 = 9.0

p1 = 13.0
p2 = 10.1

a1 = pcr / (tau1^2 * p1^2 * N * q)
a2 = pcr / (tau2^2 * p2^2 * N * q)

b = pcr / (
    tau1^2 * tau2^2 *
    p1^2 * p2^2 *
    N * q
)

c1 = (pcr - p1) / (tau1 * p1)
c2 = (pcr - p2) / (tau2 * p2)

# Нормированные коэффициенты
A1 = a1 / c1
A2 = a2 / c1
B = b / c1
C2 = c2 / c1

println()
println("Исходные данные:")
println("M1(0) = ", M10)
println("M2(0) = ", M20)
println("pcr   = ", pcr)
println("N     = ", N)
println("q     = ", q)
println("tau1  = ", tau1)
println("tau2  = ", tau2)
println("p1    = ", p1)
println("p2    = ", p2)

println()
println("Коэффициенты:")
println("a1 = ", a1)
println("a2 = ", a2)
println("b  = ", b)
println("c1 = ", c1)
println("c2 = ", c2)

println()
println("Нормированные коэффициенты:")
println("a1/c1 = ", A1)
println("a2/c1 = ", A2)
println("b/c1  = ", B)
println("c2/c1 = ", C2)

u0 = [M10, M20]

# Интервал безразмерного времени θ
tspan = (0.0, 30.0)

# СЛУЧАЙ 1
function system_case1!(du, u, p, theta)

    M1 = u[1]
    M2 = u[2]

    du[1] = M1 -
            B * M1 * M2 -
            A1 * M1^2

    du[2] = C2 * M2 -
            B * M1 * M2 -
            A2 * M2^2
end

problem1 = ODEProblem(system_case1!, u0, tspan)

solution1 = solve(
    problem1,
    Tsit5(),
    saveat = 0.01
)

plot1 = plot(
    solution1.t,
    solution1[1, :],
    label = "Фирма 1",
    linewidth = 2,
    xlabel = "θ = t/c₁",
    ylabel = "M₁, M₂",
    title = "Случай 1: динамика оборотных средств",
    legend = :bottomright,
    grid = true
)

plot!(
    plot1,
    solution1.t,
    solution1[2, :],
    label = "Фирма 2",
    linewidth = 2
)

display(plot1)

savefig(plot1, "case1_variant49.png")


det = A1 * A2 - B^2

M1_star = (A2 - B * C2) / det
M2_star = (A1 * C2 - B) / det

println("M1* = ", M1_star)
println("M2* = ", M2_star)

# Проверка подстановкой в систему
check1 = M1_star -
         B * M1_star * M2_star -
         A1 * M1_star^2

check2 = C2 * M2_star -
         B * M1_star * M2_star -
         A2 * M2_star^2

println()
println("Проверка:")
println("dM1/dθ = ", check1)
println("dM2/dθ = ", check2)

# СЛУЧАЙ 2

social = 0.00029

function system_case2!(du, u, p, theta)

    M1 = u[1]
    M2 = u[2]

    du[1] = M1 -
            (B + social) * M1 * M2 -
            A1 * M1^2

    du[2] = C2 * M2 -
            B * M1 * M2 -
            A2 * M2^2
end

problem2 = ODEProblem(system_case2!, u0, tspan)

solution2 = solve(
    problem2,
    Tsit5(),
    saveat = 0.01
)

plot2 = plot(
    solution2.t,
    solution2[1, :],
    label = "Фирма 1",
    linewidth = 2,
    xlabel = "θ = t/c₁",
    ylabel = "M₁, M₂",
    title = "Случай 2: динамика оборотных средств",
    legend = :bottomright,
    grid = true
)

plot!(
    plot2,
    solution2.t,
    solution2[2, :],
    label = "Фирма 2",
    linewidth = 2
)

display(plot2)

savefig(plot2, "case2_variant49.png")

println()
println("==============================================")
println("РЕЗУЛЬТАТЫ")
println("==============================================")

println()
println("Случай 1:")
println("M1(30) = ", solution1[1, end])
println("M2(30) = ", solution1[2, end])

println()
println("Случай 2:")
println("M1(30) = ", solution2[1, end])
println("M2(30) = ", solution2[2, end])

println()
println("Дополнительный коэффициент случая 2 = ", social)

println()
println("Графики сохранены:")
println("case1_variant49.png")
println("case2_variant49.png")