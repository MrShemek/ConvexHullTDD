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

println("All tests passed")
