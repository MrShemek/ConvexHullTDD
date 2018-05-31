using SortingAlgorithms

function main(points)
  try
    ch_points = []
    ch_points = convex_hull!(points)

    output = [[],[],[],[]]

    for ch_point in ch_points
      push!(output[1], ch_point[1])
      push!(output[2], ch_point[2])

      deleteat!(points, findfirst(points, ch_point))
    end
    
    for point in points 
      push!(output[3], point[1])
      push!(output[4], point[2])
    end

    return output
  catch e
    if isa(e, MethodError)
      return "Please provide array of tuples where each element is Int64"
    else
      return e
    end
  end
end

function convex_hull!(points::Array{Tuple{Int64,Int64},1})
  if size(points, 1) < 3
    return points
  end

  # Sort all points
  points = sort!(union(points), alg = HeapSort)

  # Arrays for top and bottom parts of convex hull
  calculated_ch_top = []
  calculated_ch_bottom = []

  # Build top part of convex hull
  build_convex_hull_part!(calculated_ch_top, points, 1:1:length(points))

  # Build bottom part of convex hull
  build_convex_hull_part!(calculated_ch_bottom, points, length(points):-1:1)

  # Remove duplicated points:
  # End of top part == beginning of the bottom part
  pop!(calculated_ch_top)

  # End of bottom part == beginning of the top part
  pop!(calculated_ch_bottom)

  # Top + Bottom parts == convex hull
  convex_hull = [calculated_ch_top; calculated_ch_bottom]

  return convex_hull
end

function counter_clockwise(p1, p2, p3)
  return ((p2[1] - p1[1]) * (p3[2] - p1[2])) - ((p2[2] - p1[2]) * (p3[1] - p1[1]))
end

function generate_points(number_of_points, range_min, range_max)
  points = [(0,0)]
  pop!(points)
  for i = 1:number_of_points
    generated_point = (rand(range_min:range_max), rand(range_min:range_max))
    push!(points, generated_point)
  end
  return points
end  

function build_convex_hull_part!(hull_points, points_to_check, iterator_range)
  for i = iterator_range
    point = points_to_check[i]

    while length(hull_points) > 1 && counter_clockwise(hull_points[end-1], hull_points[end], point) >= 0
      pop!(hull_points)
    end

    push!(hull_points, point)
  end
end