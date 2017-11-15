def numbers_output(count)
  @numbers = (1..count).to_a

  while count > 0
    puts buf = @numbers.sample
    @numbers.delete(buf)
    count -= 1
  end
end

numbers_output(ARGV[0].to_i)
