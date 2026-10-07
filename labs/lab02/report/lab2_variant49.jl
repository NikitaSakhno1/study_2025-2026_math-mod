using Plots
using DifferentialEquations


k = 16.8
n = 4.6

phi = pi / 4

a = sqrt(n^2 - 1)

println("Лабораторная работа 2")
println("Вариант 49")
println()
println("Начальное расстояние k = ", k, " км")
println("Отношение скоростей n = ", n)
println("sqrt(n^2 - 1) = ", a)
println()

# 2 случая

r01 = k / (n + 1)
r02 = k / (n - 1)

println("Случай 1:")
println("r01 = ", r01, " км")
println()

println("Случай 2:")
println("r02 = ", r02, " км")
println()

function trajectory!(du, u, p, theta)
    du[1] = u[1] / a
end

# случай 1

theta01 = 0.0
theta_end = phi

problem1 = ODEProblem(
    trajectory!,
    [r01],
    (theta01, theta_end)
)

solution1 = solve(
    problem1,
    Tsit5(),
    saveat=0.005
)

theta1 = solution1.t
r1 = [u[1] for u in solution1.u]

x1 = r1 .* cos.(theta1)
y1 = r1 .* sin.(theta1)

rmeet1 = r1[end]

xmeet1 = rmeet1 * cos(phi)
ymeet1 = rmeet1 * sin(phi)

println("СЛУЧАЙ 1")
println("Точка пересечения:")
println("x = ", xmeet1, " км")
println("y = ", ymeet1, " км")
println()

s1 = range(0, rmeet1, length=300)

xboat1 = s1 .* cos(phi)
yboat1 = s1 .* sin(phi)

plot(
    xboat1,
    yboat1,
    label="Лодка",
    linewidth=2,
    xlabel="x, км",
    ylabel="y, км",
    title="Траектории катера и лодки — случай 1",
    legend=:topleft,
    aspect_ratio=:equal
)

plot!(
    x1,
    y1,
    label="Катер",
    linewidth=2
)

scatter!(
    [xmeet1],
    [ymeet1],
    label="Точка пересечения",
    markersize=7
)

savefig("variant50_case1.png")

#случай 2

theta02 = -pi

problem2 = ODEProblem(
    trajectory!,
    [r02],
    (theta02, theta_end)
)

solution2 = solve(
    problem2,
    Tsit5(),
    saveat=0.005
)

theta2 = solution2.t
r2 = [u[1] for u in solution2.u]

x2 = r2 .* cos.(theta2)
y2 = r2 .* sin.(theta2)

rmeet2 = r2[end]

xmeet2 = rmeet2 * cos(phi)
ymeet2 = rmeet2 * sin(phi)

println("СЛУЧАЙ 2")
println("Точка пересечения:")
println("x = ", xmeet2, " км")
println("y = ", ymeet2, " км")
println()

s2 = range(0, rmeet2, length=300)

xboat2 = s2 .* cos(phi)
yboat2 = s2 .* sin(phi)

plot(
    xboat2,
    yboat2,
    label="Лодка",
    linewidth=2,
    xlabel="x, км",
    ylabel="y, км",
    title="Траектории катера и лодки — случай 2",
    legend=:topleft,
    aspect_ratio=:equal
)

plot!(
    x2,
    y2,
    label="Катер",
    linewidth=2
)

scatter!(
    [xmeet2],
    [ymeet2],
    label="Точка пересечения",
    markersize=7
)

savefig("variant50_case2.png")

println("Графики сохранены:")
println("variant50_case1.png")
println("variant50_case2.png")
