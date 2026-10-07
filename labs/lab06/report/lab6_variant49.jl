using DifferentialEquations
using Plots

α = 0.01
β = 0.02
I_star = 300
N = 5424

I0_1 = 145
R0_1 = 9
S0_1 = N - I0_1 - R0_1

function epidemic1!(du, u, p, t)
    S, I, R = u

    if I > I_star
        du[1] = -α * S * I
        du[2] = α * S * I - β * I
        du[3] = β * I
    else
        du[1] = 0
        du[2] = -β * I
        du[3] = β * I
    end
end

u0_1 = [S0_1, I0_1, R0_1]

tspan = (0.0, 200.0)

prob1 = ODEProblem(epidemic1!, u0_1, tspan)
sol1 = solve(prob1)

plot(
    sol1,
    xlabel = "Время t",
    ylabel = "Число людей",
    label = ["S(t)" "I(t)" "R(t)"],
    title = "Вариант 49: I(0) ≤ I*",
    linewidth = 2,
    legend = :right
)

I0_2 = 400
R0_2 = 9
S0_2 = N - I0_2 - R0_2

u0_2 = [S0_2, I0_2, R0_2]

prob2 = ODEProblem(epidemic1!, u0_2, tspan)
sol2 = solve(prob2)

plot(
    sol2,
    xlabel = "Время t",
    ylabel = "Число людей",
    label = ["S(t)" "I(t)" "R(t)"],
    title = "Вариант 49: I(0) > I*",
    linewidth = 2,
    legend = :right
)

p1 = plot(
    sol1,
    xlabel = "Время t",
    ylabel = "Число людей",
    label = ["S(t)" "I(t)" "R(t)"],
    title = "I(0) ≤ I*",
    linewidth = 2,
    legend = :right
)

p2 = plot(
    sol2,
    xlabel = "Время t",
    ylabel = "Число людей",
    label = ["S(t)" "I(t)" "R(t)"],
    title = "I(0) > I*",
    linewidth = 2,
    legend = :right
)

p = plot(
    p1,
    p2,
    layout = (2, 1),
    size = (900, 900)
)

savefig(p, raw"C:\Users\nikit\Desktop\JuliaLabs\lab6_variant49.png")