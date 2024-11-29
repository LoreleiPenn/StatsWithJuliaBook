(∪)(A::Set, B::Set) = union(A, B)
(∩)(A::Set, B::Set) = intersect(A, B)
(\)(A::Set, B::Set) = setdiff(A, B)
(⊂)(A::Set, B::Set) = issubset(A, B)
complement(A::Set, ω::Set) = ω \ A
symDiff(A::Set, B::Set) = (A \ B) ∪ (B \ A)

function BasicSetOperations()
    A = Set([2, 7, 2, 3])
    B = Set(1:6)
    ω = Set(1:10)
    a = 6

    println("A = $A, B = $B")
    println("A ∪ B = $(A ∪ B)")
    println("A ∩ B = $(A ∩ B)")
    println("B \\ A = ", B \ A)
    println("B' = $(complement(B, ω))")
    println("A Δ B = ", symDiff(A, B))
    println("The element '$a' is an element of A: $(a ∈ A)")
    println("Symmetric difference and intersection are subsets of the union: ",
            symDiff(A, B) ⊂ (A ∪ B), ", ", (A ∩ B) ⊂ (A ∪ B))
end

function main()
    BasicSetOperations()
end