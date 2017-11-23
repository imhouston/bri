def numbers_output(count)
  @numbers = (1..count).to_a

  count.times { |iter| puts @numbers.delete_at(rand(count-iter)) }
end

numbers_output(ARGV[0].to_i)
