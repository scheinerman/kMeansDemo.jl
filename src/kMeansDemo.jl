module kMeansDemo
using Plots, SimpleDrawing

export draw_list, one_step, double_cluster, rand_split, double_square

# export rand_split_list, one_step, nearer_to

"""
    nearer_to(x::Complex, a::Complex, b::Complex)::Int

Return `1` is `x` is closer to `a` or `2` is closer to `b`.
"""
function nearer_to(x::Complex, a::Complex, b::Complex)
    da = abs(x - a)
    db = abs(x - b)
    return da < db ? 1 : 2
end

"""
    split_list(a::Complex, b::Complex, list::Vector{Complex})

Partition the values in `list` based on whether they are closer to `a`
or to `b`. Returns two lists, the first being those closer to `a` and 
the second being those closer to `b`.
"""
function split_list(a::Complex{T}, b::Complex{S}, list::Vector) where {S,T}
    n = length(list)
    a_list = [z for z in list if nearer_to(z, a, b) == 1]
    b_list = [z for z in list if nearer_to(z, a, b) == 2]
    return a_list, b_list
end


"""
    rand_split(list::Vector{T}) where {T}

Split a list of elements into two lists at random:
`a,b = rand_split(list)`.
"""
function rand_split(list::Vector{T}) where {T}
    n = length(list)
    idx = [mod(rand(Int), 2) for _ = 1:n]

    a = [list[k] for k = 1:n if idx[k] == 0]
    b = [list[k] for k = 1:n if idx[k] == 1]
    return a, b
end

avg(list::Vector) = sum(list) / length(list)


function one_step(alist::Vector, blist::Vector)
    a = avg(alist)
    b = avg(blist)

    aa, bb = split_list(a, b, [alist; blist])

    if aa == alist && bb == blist
        @info "No change"
    end

    return aa, bb
end

# one_step(list::Vector) = rand_split_list(list)


function draw_one(z::Complex, the_color = :red)
    draw_point(z, marker = 2, markerstrokecolor = the_color, markercolor = the_color)
end

"""
    draw_list(zlist::Vector, the_color = :red)

Draw the points in `zlist` in the color `the_color`.
"""
function _draw_list(zlist::Vector, the_color = :red)
    for z in zlist
        draw_one(z, the_color)
    end
end

"""
    draw_list(alist::Vector, blist::Vector)
    draw_list(alist::Vector)

Plot one or two lists of points. First list is blue. Second 
list is red. 
"""
function draw_list(alist::Vector, blist::Vector)
    newdraw()
    _draw_list(alist, :blue)
    _draw_list(blist, :red)
    finish()
end


function draw_list(alist::Vector)
    newdraw()
    _draw_list(alist,:blue)
    finish()
end

"""
    double_cluster(n::Int=1000, z::Number = 5)::Vector{Complex{Float64}}

Create `2n` points with `n` chosen Gaussian around 0 and `n` chosen Gaussian around `z`. 
"""
function double_cluster(n::Int=1000, z::Number = 5)::Vector{Complex{Float64}}
    p1 = randn(ComplexF64,n)
    p2 = randn(ComplexF64,n) .+ z
    return [p1;p2]
end

"""
    double_square(n::Int = 1000, z::Number = 0.7+0.7im)::Vector{ComplexF64}

Similar to `double_cluster` but points are uniform in the unit square and offset
by `z`.
"""
function double_square(n::Int = 1000, z::Number = 0.7+0.7im)::Vector{ComplexF64}
    p1 = rand(ComplexF64,n)
    p2 = rand(ComplexF64,n) .+ z 
    return [p1;p2]
end


end # module kMeansDemo
