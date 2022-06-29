using Plots

# Define the imaginary unit with 𝑖.
𝑖 = im

function graphCreator(n::Int)
    vertices = 1:n
    complexPts = [exp(2*π*𝑖*k/n) for k ∈ vertices]
    coords = [(real(p), imag(p)) for p ∈ complexPts]
    xPts = first.(coords)
    yPts = last.(coords)
    edges = []
    for v ∈ vertices, u ∈ (v+1):n
        push!(edges, (v, u))
    end

    anim = Animation()
    scatter(xPts, yPts, color=:blue, msw=0, ratio=1,
            xlims=(-1.5, 1.5), ylims=(-1.5, 1.5), legend=:none)
    
    for i ∈ 1:length(edges)
        u, v = edges[i][1], edges[i][2]
        xpoints = [xPts[u], xPts[v]]
        ypoints = [yPts[u], yPts[v]]
        plot!(xpoints, ypoints, line=(:red))
        frame(anim)
    end

    gif(anim, "graph.gif", fps=60)
end

graphCreator(32)