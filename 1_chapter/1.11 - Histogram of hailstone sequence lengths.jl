using Plots

function hailLength(x::Int)
    n = 0
    while x ≠ 1
        if x % 2 == 0
            x = Int(x/2)
        else
            x = 3*x + 1
        end
        n += 1
    end
    return n
end

lengths = [hailLength(x₀) for x₀ ∈ 2:10^7]

histogram(lengths, bins=1000, normed=:true,
          fill=(:blue, true), la=0, legend=:none,
          xlims=(0, 500), ylims=(0, 0.012),
          xlabel="Length", ylabel="Frequency")