using Random, StatsBase, Combinatorics
Random.seed!(1)

function bruteSetsProbabilityAllMiss(n::Int)
    ω = collect(permutations(1:n))
    matchEvents = []
    for i ∈ 1:n
        event = []
        for p ∈ ω
            if p[i] == i
                push!(event, p)
            end
        end
        push!(matchEvents, event)
    end
    noMatch = setdiff(ω, union(matchEvents...))
    return length(noMatch)/length(ω)
end

function mcAllMiss(n::Int, N::Int)
    function envelopeStuffer(n::Int)
        envelopes = Random.shuffle!(collect(1:n))
        return sum([envelopes[i] == i for i ∈ 1:n]) == 0
    end
    data = [envelopeStuffer(n) for _ ∈ 1:N]
    return sum(data)/N
end

function secretaryWithEnvelopes()
    N = 10^6
    formulaCalcAllMiss(n::Int) = sum([(-1)^k/factorial(k) for k in 0:n])
    println("n\tBrute Force\tFormula\t\tMonte Carlo\tAsymptotic")
    for n ∈ 1:6
        bruteForce = bruteSetsProbabilityAllMiss(n)
        fromFormula = formulaCalcAllMiss(n)
        fromMc = mcAllMiss(n, N)
        asymptotic = 1/MathConstants.e
        results = [bruteForce, fromFormula, fromMc, asymptotic]
        roundedResults = map(result -> round(result, digits=4), results)
        printResults = join(roundedResults, "\t\t")
        println(n, "\t", printResults)
    end
end