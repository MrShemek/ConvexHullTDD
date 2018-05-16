include("convex_hull.jl")

using FactCheck

# Test 1
# convex_hull function accepts only array of tuples
# If other values was passed, then it raises an exception
facts("Validate convex_hull function arguments") do
  @fact main("STRING") --> "Please provide array of tuples where each element is Int64"
  @fact main(("string","string")) --> "Please provide array of tuples where each element is Int64"
  @fact main([(1.23, 5.55)]) --> "Please provide array of tuples where each element is Int64"
end

# Test 2
# If the number of points is smaller than 3, then return the input
facts("Return input when it contains less than 3 points") do
  @fact convex_hull([(0,0)]) --> [(0,0)]
  @fact convex_hull([(0,1),(0,2)]) --> [(0,1),(0,2)]
end

# Test 3
# Detect direction based on the three points
facts("Detect direction based on three points") do
  @fact counter_clockwise((0,1), (1,1),  (2,2))   > 0 --> true
  @fact counter_clockwise((0,1), (-1,-1),(-2,-2)) < 0 --> true
  @fact counter_clockwise((0,1), (0,2),  (0,3))   --> 0
end

# Test 4
facts("Generates array of points and returns it") do
  @fact size(generate_points(10, -30, 30),1) == 10 --> true
  @fact typeof(generate_points(10,-30,30)) == Array{Any,1} --> true
end

println("All tests passed")
