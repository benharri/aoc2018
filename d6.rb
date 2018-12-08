points = (ARGV.empty? ? DATA : ARGF).each_line.map { |l|
  l.split(', ').map(&:to_i).freeze
}.freeze

ymin, ymax = points.map(&:first).minmax
xmin, xmax = points.map(&:last).minmax

owned = [0] * points.size
infinite = [false] * points.size
within = 0

# Part 1
# Calculate closest labeled point for all points within the bounding box.
# Anything that keeps growing beyond the box we'll call "infinite"
#
# Theretically, we *should* allow a margin to deal w/ cases like this:
# A     B
#    C
#    D
# ... even though no such margin is necessary for my input.
#
# So I'll just arbitrarily set a small one.
#
# (Do part 2 while we're here too)
MARGIN = 2
yrange = (ymin - MARGIN * 2)..(ymax + MARGIN * 2)
xrange = (xmin - MARGIN * 2)..(xmax + MARGIN * 2)
yrange.each { |y|
  inside_y = ((ymin - MARGIN)..(ymax + MARGIN)).cover?(y)
  edge_y = y == yrange.begin || y == yrange.end

  xrange.each { |x|
    best_dist = 1.0 / 0.0
    best = nil
    dist_sum = 0

    points.each_with_index { |(yy, xx), i|
      dist_sum += dist = (yy - y).abs + (xx - x).abs
      if dist < best_dist
        best = i
        best_dist = dist
      elsif dist == best_dist
        best = nil
      end
    }

    if dist_sum < 10000
      within += 1
      edge_x = x == xrange.begin || x == xrange.end
      puts "DANGER! SAFE ON EDGE #{y}, #{x}" if edge_y || edge_x
    end

    next unless best

    if inside_y && ((xmin - MARGIN)..(xmax + MARGIN)).cover?(x)
      owned[best] += 1
    else
      infinite[best] = true
    end
  }
}

puts owned.zip(infinite).reject(&:last).map(&:first).max
puts within

__END__
267, 196
76, 184
231, 301
241, 76
84, 210
186, 243
251, 316
265, 129
142, 124
107, 134
265, 191
216, 226
67, 188
256, 211
317, 166
110, 41
347, 332
129, 91
217, 327
104, 57
332, 171
257, 287
230, 105
131, 209
110, 282
263, 146
113, 217
193, 149
280, 71
357, 160
356, 43
321, 123
272, 70
171, 49
288, 196
156, 139
268, 163
188, 141
156, 182
199, 242
330, 47
89, 292
351, 329
292, 353
290, 158
167, 116
268, 235
124, 139
116, 119
142, 259
