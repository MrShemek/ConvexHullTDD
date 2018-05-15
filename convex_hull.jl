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