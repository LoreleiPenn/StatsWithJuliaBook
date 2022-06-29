using Random, LinearAlgebra, Plots

N = 10^5
data = [(rand(), rand()) for _ in 1:N]
inside = filter(x -> norm(x) <= 1, data)
outside = filter(x -> norm(x) > 1, data)
πAproxx = 4 * length(inside)/N
println("Approximate of π: $(πAproxx)")

scatter(first.(inside), last.(inside), cs=:blue, ms=1, msw=0)
scatter!(first.(outside), last.(outside), cs=:red, ms=1, msw=0,
        xlims=(0, 1), ylims=(0, 1), legend=:none, ratio=:equal)