using Random, StatsBase

(∪)(A::Set, B::Set) = union(A, B)
(∩)(A::Set, B::Set) = intersect(A, B)
(\)(A::Set, B::Set) = setdiff(A, B)
(⊂)(A::Set, B::Set) = issubset(A, B)
complement(A::Set) = ω \ A
symDiff(A::Set, B::Set) = (A \ B) ∪ (B \ A)

function anInnocentMistakeMonteCarlo()
    Random.seed!(1)

    A = Set(['a', 'e', 'i', 'o', 'u'])
    B = Set(['x', 'y', 'z'])
    AuB = A ∪ B
    ω = 'a':'z'

    N = 10^6
    println("mcEst1 \t \tmcEst2")
    for _ in 1:5
        mcEst1 = sum([sample(ω) ∈ A || sample(ω) ∈ B for _ in 1:N])/N
        mcEst2 = sum([sample(ω) ∈ AuB for _ in 1:N])/N
        println(mcEst1, "\t", mcEst2)
    end
end

function main()
    anInnocentMistakeMonteCarlo()
end