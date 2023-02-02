# `kMeansDemo`

This is a small demonstration project of k-means clustering with k=2 and in two dimensions.

## Point Sets

Points are represented as complex numbers. Input to the method is a list (`Vector`) of points. 

For demonstration purposes, we provide the function `double_cluster` to generate a set of points. 

Usage: `double_cluster(n, offset)` generates a list of `2n` points. The first `n` points are
Gaussian normal centered around the origin and the second `n` points are Gaussian normal 
centered around `offset`. 

For example, `double_cluster(1000, 3+3im)`. 

## Single stepping through the k-means algorithm

The function `one_step` is used to perform one step of the `k`-means algorithm. 

If `pts` is the list of points, then `a,b = rand_split(pts)` partitions `pts` into two lists 
`a` and `b` by randomly assigning points to `a` or `b`.

Invocations of `one_step` looks like this `a,b = one_step(a,b)`. If the new partition 
is the same as the given partition, the message `No change` is displayed.

## Visualization

`draw_list(pts)` plots all points in `list` as blue dots.

`draw_list(a,b)` plots the points in `a` in blue and the points in `b` in red. 

## Example

### Two Gaussian clusters

```
julia> using kMeansDemo

julia> pts = double_cluster(1000, 5);

julia> a,b = rand_split(pts);

julia> a,b = one_step(a,b);

julia> a,b = one_step(a,b);

julia> a,b = one_step(a,b);
[ Info: No change

julia> draw_list(a,b)
```

The result looks like this: 
![](./example-1.png)

### Two uniform (square) clusters

```
julia> pts = double_square(1000, 0.7+0.7im);

julia> a,b = rand_split(pts);

julia> a,b = one_step(a,b);

julia> a,b = one_step(a,b);

julia> a,b = one_step(a,b);

julia> a,b = one_step(a,b);

julia> a,b = one_step(a,b);
[ Info: No change

julia> draw_list(a,b)
```

The result lookds like this:
![](./example-2.png)
