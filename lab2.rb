require 'benchmark'
@x_min = @y_min = @z_min = 0
@x_max = @y_max = @z_max = 1
@step = 0.0001
@quantity = 100_000_000
@a_param = @n_param = @k_param = 1.0

@function_1 = -> x {@a_param.to_f * (1.0 - x.to_f) * x.to_f}
@function_2 = -> y {Math.exp(-@n_param.to_f * y.to_f)}
@function_3 = -> z {Math.sin(Math::PI * @k_param.to_f * z.to_f)}

direct_integration = -> {
  function_1 = -> x {-@a_param * (x ** 2.0) * (2.0 * x - 3.0) / 6.0}
  function_2 = -> y {-Math.exp(-@n_param * y) / @n_param}
  function_3 = -> z {-Math.cos(Math::PI * @k_param * z) / (Math::PI * @k_param)}
  (function_1.call(@x_min) - function_1.call(@x_max)).abs *
    (function_2.call(@y_min) - function_2.call(@y_max)).abs *
    (function_3.call(@z_min) - function_3.call(@z_max)).abs
}
rect_method_integration = ->(min, max, step, function) {
  sum = 0
  (min..max).step(step) { |variable|
    sum += function.call(variable)
  }
  sum * step
}

error1_runge = -> {
  error_1 = 0
  s_h = rect_method_integration.call(@x_min, @x_max, @step, @function_1)
  s_2h = rect_method_integration.call(@x_min, @x_max, 2 * @step, @function_1)
  error_1 += s_h - s_2h
  s_h = rect_method_integration.call(@y_min, @y_max, @step, @function_2)
  s_2h = rect_method_integration.call(@y_min, @y_max, 2 * @step, @function_2)
  error_1 += s_h - s_2h
  s_h = rect_method_integration.call(@z_min, @z_max, @step, @function_3)
  s_2h = rect_method_integration.call(@z_min, @z_max, 2 * @step, @function_3)
  error_1 += s_h - s_2h
  (error_1 / 3.0).abs
}

the_simplest_monte_carlo = ->(min, max, func) {
  sum = 0
  (0...@quantity).each {
    sum += func.call(rand(min.to_f...max.to_f))
  }
  (max - min) * sum / @quantity
}

@simple_dispersion = ->(min, max, func) {
  sum = 0
  sum_2 = 0
  (0...@quantity).each {
    f = func.call(rand(min.to_f...max.to_f))
    sum += f
    sum_2 += f ** 2
  }
  (sum_2 / @quantity - (sum / @quantity) ** 2) / @quantity
}

def simple_sigma
  sigma_1 = (@x_max - @x_min) * Math.sqrt(@simple_dispersion.call(@x_min, @x_max, @function_1))
  sigma_2 = (@y_max - @y_min) * Math.sqrt(@simple_dispersion.call(@y_min, @y_max, @function_2))
  sigma_3 = (@z_max - @z_min) * Math.sqrt(@simple_dispersion.call(@z_min, @z_max, @function_3))
  (sigma_1 + sigma_2 + sigma_3) / 3.0
end

geometric_monte_carlo = ->(min, max, func) {
  min_max = find_min_max(min, max, func)
  f_min = min_max[0]
  f_max = min_max[1]
  n_1 = 0
  (0...@quantity).each {
    x = min + (max - min) * rand(min.to_f..max.to_f)
    y = f_min + (f_max - f_min) * rand(min.to_f..max.to_f)
    if func.call(x) > y
      n_1 += 1
    end
  }
  (max - min) * ((f_max - f_min) * n_1 / @quantity + f_min)
}

epsilon = -> (min, max, func) {
  x_i = rand(min.to_f..max.to_f)
  y_i = rand(min.to_f..max.to_f)
  func.call(x_i) > y_i ? 0 : 1
}

@geom_dispersion = ->(min, max, func) {
  sum = 0
  (0...@quantity).each {
    sum += epsilon.call(min, max, func)
  }
  sum.to_f / @quantity * (1.0 - sum.to_f / @quantity)
}

def geometric_sigma
  min_max = find_min_max(@x_min, @x_max, @function_1)
  sigma_1 = (@x_max - @x_min) * (min_max[1] - min_max[0]) * Math.sqrt(@geom_dispersion.call(@x_min, @x_max, @function_1) / @quantity)
  min_max = find_min_max(@y_min, @y_max, @function_2)
  sigma_2 = (@y_max - @y_min) * (min_max[1] - min_max[0]) * Math.sqrt(@geom_dispersion.call(@y_min, @y_max, @function_2) / @quantity)
  min_max = find_min_max(@z_min, @z_max, @function_3)
  sigma_3 = (@z_max - @z_min) * (min_max[1] - min_max[0]) * Math.sqrt(@geom_dispersion.call(@z_min, @z_max, @function_3) / @quantity)
  (sigma_1 + sigma_2 + sigma_3) / 3.0
end

def find_min_max(min, max, func)
  f_min = f_max = func.call(min)
  (0...@quantity).each { |val|
    f = func.call((max - min).to_f / @quantity * val)
    if f < f_min
      f_min = f
    elsif f > f_max
      f_max = f
    end
  }
  [f_min, f_max]
end

def total_rect(func)
  func.call(@x_min, @x_max, @step, @function_1) *
    func.call(@y_min, @y_max, @step, @function_2) *
    func.call(@z_min, @z_max, @step, @function_3)
end

def monte_carlo_total_rect(func)
  func.call(@x_min, @x_max, @function_1) *
    func.call(@y_min, @y_max, @function_2) *
    func.call(@z_min, @z_max, @function_3)
end

puts"Enter parameters"
print "a ="
@a_param = gets.chomp.to_f
print "n ="
@n_param = gets.chomp.to_f
print "k ="
@k_param = gets.chomp.to_f


direct_integration_res = direct_integration.call
rect_res = total_rect(rect_method_integration)
rect_bench = Benchmark.measure { total_rect(rect_method_integration) }
simple_monte_res = monte_carlo_total_rect(the_simplest_monte_carlo)
sim_monte_bench = Benchmark.measure { monte_carlo_total_rect(the_simplest_monte_carlo) }
geometric_monte_res = monte_carlo_total_rect(geometric_monte_carlo)
geom_monte_bench = Benchmark.measure { monte_carlo_total_rect(geometric_monte_carlo) }


puts "\nMethod of direct integration
Result: #{direct_integration_res}"
puts "\nMethod of rectangles
Result: #{rect_res}
Error(Помилка): #{(direct_integration_res - rect_res).abs}
Error_1(Похибка): #{error1_runge.call}"
puts "Calculation time: #{rect_bench.real} c"
puts "\nThe simplest Monte Carlo method
Result: #{simple_monte_res}
Error(Помилка): #{(direct_integration_res - simple_monte_res).abs}
Error_1(Похибка): #{simple_sigma}"
puts "Calculation time: #{sim_monte_bench.real} c"
puts "\nMonte Carlo geometric method
Result: #{geometric_monte_res}
Error(Помилка): #{(direct_integration_res - geometric_monte_res).abs}
Error_1(Похибка): #{geometric_sigma}"
puts "Calculation time: #{geom_monte_bench.real} c"