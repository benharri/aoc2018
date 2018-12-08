TEST = ARGV.delete('-t')
VERBOSE = ARGV.delete('-v')

def work(deps, parallelism, work_factor)
  remaining = deps.flatten.uniq

  doable = -> {
    remaining.select { |t|
      deps.none? { |_, y| y == t }
    }.min
  }

  goal = remaining.size
  done = ''
  # each element is [task_id, finish_time]
  workers = [nil] * parallelism
  deps = deps.dup

  0.step { |t|
    # Has anyone finished a task?
    workers.each_with_index { |(task, finish_time), i|
      next unless finish_time&.<=(t)
      done << task
      workers[i] = nil
      deps.reject! { |x, _| x == task }
      puts "t=#{t} worker #{i} finishes #{task}" if VERBOSE
    }
    # Assign tasks to anyone free
    workers.each_index { |i|
      next if workers[i]
      break unless (todo = doable[])
      finish_time = t + work_factor + todo.ord - ?A.ord
      puts "t=#{t} assign task #{todo} to #{i}, finishes at #{finish_time}" if VERBOSE
      workers[i] = [todo, finish_time]
      remaining.delete(todo)
    }
    break [done, t] if done.size == goal
  }
end

deps = (ARGV.empty? ? DATA : ARGF).each_line.map { |l|
  l.scan(/[A-Z]/).drop(1).freeze
}.freeze

if TEST
  deps = %w(CA CF AB AD BE DE FE).map(&:chars).map(&:freeze).freeze
  puts work(deps, 1, -30)[0]
  puts work(deps, 2, 1)[1]
else
  puts work(deps, 1, -30)[0]
  puts work(deps, 5, 61)[1]
end

__END__
Step T must be finished before step X can begin.
Step G must be finished before step O can begin.
Step X must be finished before step B can begin.
Step I must be finished before step W can begin.
Step N must be finished before step V can begin.
Step K must be finished before step H can begin.
Step S must be finished before step R can begin.
Step P must be finished before step J can begin.
Step L must be finished before step V can begin.
Step D must be finished before step E can begin.
Step J must be finished before step R can begin.
Step U must be finished before step W can begin.
Step M must be finished before step Q can begin.
Step B must be finished before step F can begin.
Step F must be finished before step E can begin.
Step V must be finished before step Q can begin.
Step C must be finished before step A can begin.
Step H must be finished before step Z can begin.
Step A must be finished before step Y can begin.
Step O must be finished before step Y can begin.
Step W must be finished before step Q can begin.
Step E must be finished before step Y can begin.
Step Y must be finished before step Z can begin.
Step Q must be finished before step R can begin.
Step R must be finished before step Z can begin.
Step S must be finished before step E can begin.
Step O must be finished before step W can begin.
Step G must be finished before step B can begin.
Step I must be finished before step N can begin.
Step G must be finished before step I can begin.
Step H must be finished before step R can begin.
Step N must be finished before step C can begin.
Step M must be finished before step W can begin.
Step Y must be finished before step R can begin.
Step T must be finished before step B can begin.
Step G must be finished before step D can begin.
Step J must be finished before step O can begin.
Step I must be finished before step A can begin.
Step J must be finished before step H can begin.
Step T must be finished before step Y can begin.
Step N must be finished before step H can begin.
Step B must be finished before step V can begin.
Step M must be finished before step R can begin.
Step Y must be finished before step Q can begin.
Step X must be finished before step J can begin.
Step A must be finished before step E can begin.
Step P must be finished before step Z can begin.
Step P must be finished before step C can begin.
Step N must be finished before step Q can begin.
Step A must be finished before step O can begin.
Step G must be finished before step X can begin.
Step P must be finished before step U can begin.
Step T must be finished before step S can begin.
Step I must be finished before step V can begin.
Step V must be finished before step H can begin.
Step U must be finished before step F can begin.
Step D must be finished before step Q can begin.
Step D must be finished before step O can begin.
Step G must be finished before step H can begin.
Step I must be finished before step Z can begin.
Step N must be finished before step D can begin.
Step B must be finished before step Y can begin.
Step J must be finished before step M can begin.
Step V must be finished before step Y can begin.
Step W must be finished before step Y can begin.
Step E must be finished before step Z can begin.
Step T must be finished before step N can begin.
Step L must be finished before step U can begin.
Step S must be finished before step A can begin.
Step Q must be finished before step Z can begin.
Step T must be finished before step F can begin.
Step F must be finished before step Z can begin.
Step J must be finished before step C can begin.
Step X must be finished before step Y can begin.
Step K must be finished before step V can begin.
Step T must be finished before step I can begin.
Step I must be finished before step O can begin.
Step C must be finished before step W can begin.
Step B must be finished before step Q can begin.
Step W must be finished before step Z can begin.
Step D must be finished before step H can begin.
Step K must be finished before step A can begin.
Step M must be finished before step E can begin.
Step T must be finished before step U can begin.
Step I must be finished before step J can begin.
Step O must be finished before step Q can begin.
Step M must be finished before step Z can begin.
Step U must be finished before step C can begin.
Step N must be finished before step F can begin.
Step C must be finished before step H can begin.
Step X must be finished before step E can begin.
Step F must be finished before step O can begin.
Step P must be finished before step O can begin.
Step J must be finished before step A can begin.
Step H must be finished before step Y can begin.
Step A must be finished before step Q can begin.
Step V must be finished before step Z can begin.
Step S must be finished before step L can begin.
Step H must be finished before step E can begin.
Step X must be finished before step I can begin.
Step O must be finished before step R can begin.
