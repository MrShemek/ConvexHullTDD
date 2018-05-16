function main(points)
  try
    convex_hull(points)
  catch e
    if isa(e, MethodError)
      return "Please provide array of tuples where each element is Int64"
    else
      return e
    end
  end
end

function convex_hull(points::Array{Tuple{Int64,Int64},1})
  if size(points, 1) < 3
    return points
  end
end

function counter_clockwise(p1, p2, p3)
  return ((p2[1] - p1[1]) * (p3[2] - p1[2])) - ((p2[2] - p1[2]) * (p3[1] - p1[1]))
end

function generate_points(number_of_points, range_min, range_max)
  points = []
  for i = 1:number_of_points
    generated_point = (rand(range_min:range_max), rand(range_min:range_max))
    push!(points, generated_point)
  end
  return points
end  