ArgumentError = Class.new(StandardError)

def numbers_output(count)
  @numbers = (1..20).to_a

  raise ArgumentError, "Аргумент больше множества уникальных чисел" if count > @numbers.size

  while count > 0 do
    puts buf = @numbers.sample
    @numbers.delete(buf)
    count -= 1
  end
end

numbers_output(20)

