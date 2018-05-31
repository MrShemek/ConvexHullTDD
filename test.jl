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
  @fact convex_hull!([(0,0)]) --> [(0,0)]
  @fact convex_hull!([(0,1),(0,2)]) --> [(0,1),(0,2)]
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
  @fact typeof(generate_points(10,-30,30)) == Array{Tuple{Int64,Int64},1} --> true
end

# Test 5
# Check if the convex hull part is build correctly

# general case:
input1 = [(2,3),(3,0),(6,6),(5,2),(5,4),(1,1),(4,5)]
# a case with collinear point:
input2 = [(2,3),(3,0),(6,6),(3,4),(5,2),(5,4),(1,1),(4,5)]

# sorted imputs
sorted_input1 = sort!(union(input1), alg = HeapSort)
sorted_input2 = sort!(union(input2), alg = HeapSort)

# result array
result1 = []
result2 = []

build_convex_hull_part!(result1, sorted_input1, 1:1:length(sorted_input1))
build_convex_hull_part!(result2, sorted_input2, length(sorted_input2):-1:1)

facts("Checking build_convex_hull_part method") do 
    @fact result1 --> [(1,1),(2,3),(4,5),(6,6)]
    @fact result2 --> [(6,6),(5,2),(3,0),(1,1)]
end

# Test 6
# Check if convex hull is build correctly
input1 = [(0,3), (1,1), (2,2), (4,4), (0,0), (1,2), (3,1), (3,3)]
input2 = [(3,-3),(-5,-2),(0,-4),(4,3),(-2,0),(2,3),(1,6),(0,-4),(-5,5),(3,3),(-3,0),(6,0),(5,3),(2,2),(6,0),(4,-5),(-2,3),(4,5),(-3,-1),(-3,2)]
input3 = [(0,-4),(-5,-5),(-9,1),(-6,-1),(2,-10),(-4,1),(-1,-4),(2,7),(0,3),(-9,2),(3,-10),(9,5),(8,3),(10,-2),(-6,-7),(0,-9),(-10,-9),(-3,8),(9,4),(2,1),(-8,0),(-6,-9),(-10,3),(6,-7),(2,-2),(4,-5),(0,9),(-2,3),(8,-4),(5,-5)]

result1 = convex_hull!(input1)
result2 = convex_hull!(input2)
result3 = convex_hull!(input3)

facts("Check builing complete convex hull") do
  @fact result1 --> [(0,0),(0,3),(4,4),(3,1)]
  @fact result2 --> [(-5,-2),(-5,5),(1,6),(4,5),(5,3),(6,0),(4,-5),(0,-4)]
  @fact result3 --> [(-10,-9),(-10,3),(-3,8),(0,9),(9,5),(10,-2),(6,-7),(3,-10),(2,-10)]
end


println("All tests passed")
