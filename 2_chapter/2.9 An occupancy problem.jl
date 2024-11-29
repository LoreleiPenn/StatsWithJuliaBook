using Plots

function occupancyMC(n, r, N)
    fullCount = 0
    for _ in 1:N
        envelopes = zeros(Int, n)
        for k ∈ 1:r
            target = rand(1:n)
            envelopes[target] += 1
        end
        numFilled = sum( envelopes .> 0)
        if numFilled == n
            fullCount += 1
        end
    end
    return fullCount/N
end

occupancyAnalytic(n, r) = sum([(-1)^k * binomial(n, k) * (1 - k/n)^r for k in 0:n])

function anOccupancyProblem()
    maxₙ, N, kvals = 100, 10^3, [2, 3, 4]
    analytic = [[occupancyAnalytic(big(n), big(k * n)) for n ∈ 1:maxₙ] for k ∈ kvals]
    monteCarlo = [[occupancyMC(n, k*n, N) for n ∈ 1:maxₙ] for k ∈ kvals]
    plot(1:maxₙ, analytic, color=[:blue :red :green],
         label=["k=2" "k=3" "k=4"])
    scatter!(1:maxₙ, monteCarlo, mc=:black, shape=:+,
             label="", xlims=(0, maxₙ), ylims=(0, 1),
             xlabel="n Envelopes", ylabel="Probability", legend=:topright)
end