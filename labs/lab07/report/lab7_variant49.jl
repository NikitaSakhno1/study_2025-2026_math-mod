using DifferentialEquations
using Plots

N = 2020.0      
n0 = 28.0       

tspan = (0.0, 10.0)


function model1!(dn, n, p, t)
    dn[1] = (0.99 + 0.00009 * n[1]) * (N - n[1])
end

prob1 = ODEProblem(model1!, [n0], tspan)
sol1 = solve(prob1, Tsit5(), saveat=0.01)

t1 = sol1.t
n1 = [u[1] for u in sol1.u]

plot(
    t1, n1,
    xlabel = "t",
    ylabel = "n(t)",
    title = "Распространение рекламы — модель 1",
    label = "n(t)",
    lw = 2,
    legend = :bottomright
)

savefig("model1.png")

function model2!(dn, n, p, t)
    dn[1] = (0.000099 + 0.9 * n[1]) * (N - n[1])
end

prob2 = ODEProblem(model2!, [n0], tspan)
sol2 = solve(prob2, Tsit5(), saveat=0.0001)

t2 = sol2.t
n2 = [u[1] for u in sol2.u]

plot(
    t2, n2,
    xlabel = "t",
    ylabel = "n(t)",
    title = "Распространение рекламы — модель 2",
    label = "n(t)",
    lw = 2,
    legend = :bottomright
)

savefig("model2.png")

a = 0.000099
b = 0.9

# v(n) = (a + b*n)*(N-n)
# dv/dn = b*N - a - 2*b*n = 0

n_max = (b * N - a) / (2 * b)

function speed2(n)
    (a + b * n) * (N - n)
end

index_max = argmin(abs.(n2 .- n_max))

t_max = t2[index_max]
v_max = speed2(n_max)

println()
println("==========================================")
println("ВАРИАНТ №49 — МОДЕЛЬ 2")
println("==========================================")
println("n_max = ", n_max)
println("t_max ≈ ", t_max)
println("v_max ≈ ", v_max)
println("==========================================")
println()

function model3!(dn, n, p, t)
    dn[1] = (
        0.9 * sin(0.9 * t) +
        0.99 * cos(0.99 * t) * n[1]
    ) * (N - n[1])
end

tspan3 = (0.0, 5.0)

prob3 = ODEProblem(model3!, [n0], tspan3)
sol3 = solve(prob3, Tsit5(), saveat=0.001)

t3 = sol3.t
n3 = [u[1] for u in sol3.u]

plot(
    t3, n3,
    xlabel = "t",
    ylabel = "n(t)",
    title = "Распространение рекламы — модель 3",
    label = "n(t)",
    lw = 2,
    legend = :bottomright
)

savefig("model3.png")

p = plot(
    t1, n1,
    xlabel = "t",
    ylabel = "n(t)",
    title = "Распространение рекламы — вариант №49",
    label = "Модель 1",
    lw = 2
)

plot!(
    p,
    t2, n2,
    label = "Модель 2",
    lw = 2
)

plot!(
    p,
    t3, n3,
    label = "Модель 3",
    lw = 2
)

savefig("all_models.png")

display(p)

println("Графики сохранены в текущую папку:")
println("model1.png")
println("model2.png")
println("model3.png")
println("all_models.png")