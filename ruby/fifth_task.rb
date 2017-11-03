require 'csv'

arr_of_arrs = File.readlines('IpToCountry.csv')
@table = []
arr_of_arrs.each { |e| @table << e unless e[0]== '#' }
puts @table[0]
def code_ip_address(ip)
  pow = 3
  code = 0
  ip.split('.').each do |i|
    code += i.to_i*(256**pow)
    pow -= 1
  end
  code
end

def determine_country(ip_code)
  puts ip_code
  @table.each do |row|
    if row[0] == ip_code || row[1] == ip_code
      puts row[4]
      break
    end
  end
end

ip = '85.12.221.146'

determine_country(code_ip_address(ip))

names = ['from', 'to', 'reg', 'assign', 'c', 'ctr', 'country']
