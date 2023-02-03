export double_cluster, double_square, double_circle

"""
    double_cluster(n::Int=1000, z::Number = 5)::Vector{ComplexF64}

Create `2n` points with `n` chosen Gaussian around 0 and `n` chosen Gaussian around `z`. 
"""
function double_cluster(n::Int = 1000, z::Number = 5)::Vector{ComplexF64}
    p1 = randn(ComplexF64, n)
    p2 = randn(ComplexF64, n) .+ z
    return [p1; p2]
end

"""
    double_square(n::Int = 1000, z::Number = 0.7+0.7im)::Vector{ComplexF64}

Similar to `double_cluster` but points are uniform in the unit square and offset
by `z`.
"""
function double_square(n::Int = 1000, z::Number = 0.7 + 0.7im)::Vector{ComplexF64}
    p1 = rand(ComplexF64, n)
    p2 = rand(ComplexF64, n) .+ z
    return [p1; p2]
end


function one_rand_disc()
    while true
        z = 2 * rand(ComplexF64) - 1 - im
        if abs(z) <= 1
            return z
        end
    end
end

"""
    double_circle(n::Int = 1000, z::Number = 1.5)::Vector{ComplexF64}

Similar to `double_cluster` but points are uniform in the unit circle and offset
by `z`.
"""
function double_circle(n::Int = 1000, z::Number = 1.5)::Vector{ComplexF64}
    p1 = [one_rand_disc() for _ = 1:n]
    p2 = [one_rand_disc() for _ = 1:n] .+ z
    return [p1; p2]
end
