using StatsBase, Plots

function proportionFished(gF, sF, n, N, withReplacement=false)
    function fishing()
        fishInPond = [ones(Int64, gF); zeros(Int64, sF)]
        fishCaught = Int64[]

        for fish in 1:n
            fished = rand(fishInPond)
            push!(fishCaught, fished)
            if !withReplacement
                deleteat!(fishInPond, findfirst(x -> x==fished, fishInPond))
            end
        end
        sum(fishCaught)
    end

    simulations = [fishing() for _ in 1:N]
    proportions = counts(simulations, 0:n)/N

    if withReplacement
        plot!(0:n, proportions,
              line=:stem, market=:circle, c=:blue, ms=6, msw=0,
              label="With replacement",
              xlabel="n",
              ylims=(0, 0.6), ylabel="Probability")
    else
        plot!(0:n, proportions,
              line=:stem, marker=:xcross, c=:red, ms=6, msw=0,
              label="Without replacement")
    end
end

function main()
    N=10^6
    goldFish, silverFish, n = 3, 4, 3
    proportionFished(goldFish, silverFish, n, N)
    proportionFished(goldFish, silverFish, n, N, true)
end

main()