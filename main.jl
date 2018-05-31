using IJulia
using Reactive, Interact

notebook();

min_val = slider(-300:1:300,label="Min value:")
max_val = slider(-300:1:300,label="Max value:")
points_number = slider(1:1:100,label="Points number:")

include("convex_hull.jl")

points = generate_points(signal(points_number), signal(min_val), signal(max_val))
main(points)