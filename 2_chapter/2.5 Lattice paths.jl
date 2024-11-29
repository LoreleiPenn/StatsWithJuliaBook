using Random, Combinatorics, Plots, LaTeXStrings

function isUpperLattice(v)
    for i in 1:Int(length(v)/2)
        sum(v[1:2*i-1]) >= i ? continue : return false
    end
    return true
end

function randomWalkPath(n)
    x, y = 0, 0
    path = []
    while x < n && y < n
        if rand() < 0.5
            x += 1
            push!(path, 0)
        else
            y += 1
            push!(path, 1)
        end
    end
    append!(path, x<n ? zeros(Int64, n-x) : ones(Int64, n-y))
    return path
end

function plotPath(vector, n, label, colour)
    x, y = 0, 0
    graphX, graphY = [x], [y]
    for i in vector
        if i == 0
            x += 1
        else
            y += 1
        end
        push!(graphX, x), push!(graphY, y)
    end
    plot!(graphX, graphY,
          la=0.8, lw=2, label=label, color=colour, ratio=:equal, legend=:topleft,
          xlims=(0, n), ylims=(0, n),
          xlabel=L"East\rightarrow", ylabel=L"North\rightarrow")
end

function main()
    Random.seed!(12)
    n, N = 5, 10^5
    ω = unique(permutations([zeros(Int, n); ones(Int, n)]))
    A = ω[isUpperLattice.(ω)]
    pA_modelI = length(A)/length(ω)

    pA_modelIITest = sum([isUpperLattice(randomWalkPath(n)) for _ in 1:N])/N
    println("Model I: ", pA_modelI)
    println("Model II: ", pA_modelIITest)

    plot()
    plotPath(rand(A), n, "Upper lattice path", :blue)
    plotPath(rand(setdiff(ω, A)), n, "Non-upper lattice path", :red)
    plot!([0, n], [0, n], ls=:dash, c=:black, label="")
end