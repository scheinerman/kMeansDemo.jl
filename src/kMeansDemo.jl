module kMeansDemo
using Plots, SimpleDrawing

export draw_data, one_step, double_cluster, rand_split, double_square, kmeans

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
    draw_data(zlist::Vector, the_color = :red)

Draw the points in `zlist` in the color `the_color`.
"""
function _draw_data(zlist::Vector, the_color = :red)
    for z in zlist
        draw_one(z, the_color)
    end
end

"""
    draw_data(alist::Vector, blist::Vector)
    draw_data(alist::Vector)

Plot one or two lists of points. First list is blue. Second 
list is red. 
"""
function draw_data(alist::Vector, blist::Vector)
    newdraw()
    _draw_data(alist, :blue)
    _draw_data(blist, :red)
    finish()
end


function draw_data(alist::Vector)
    newdraw()
    _draw_data(alist,:blue)
    finish()
end

"""
    kmeans(pts::Vector, max_steps::Int = 10)

Perform the k-means algorithm on the data with k=2, running at most 
`max_steps` steps. Return two lists containing the points of the two 
clusters.
"""
function kmeans(pts::Vector, max_steps::Int = 10)
    a,b = rand_split(pts)
    steps = 0
    while true 
        aa,bb = one_step(a,b)
        steps += 1
        print("$steps ")
        if aa==a && bb==b
            break 
        end
        a = aa
        b = bb
        if steps >= max_steps
            @info "max steps reached"
            break
        end
    end

    return a,b
end

include("example_maker.jl")


end # module kMeansDemo
