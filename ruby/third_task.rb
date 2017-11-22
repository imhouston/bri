def numbers_output(count)
  @numbers = (1..count).to_a

  count.times do
    puts @numbers.delete(@numbers[rand(@numbers.size) - 1])
  end
end

numbers_output(ARGV[0].to_i)
