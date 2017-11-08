require 'csv'

class IpToCountry
  def initialize
    @data = CSV.read('IpToCountry.csv', row_sep: "\n", skip_lines: /^#/, encoding: 'windows-1251:utf-8',
      headers: ['from', 'to', '2', '4', 'Cntr_symbol', 'Cntry', 'Country'])
  end

  def code_ip_address(ip)
    pow = 3
    code = 0

    ip.split('.').each do |i|
      code += i.to_i * (256**pow)
      pow -= 1
    end

    code.to_s
  end

  def determine_country(ip)
    ip_code = code_ip_address(ip)

    @data.each { |d| return d['Cntr_symbol'] if d['from'] == ip_code }

    raise 'Не найден такой ip'
  end
end

puts IpToCountry.new.determine_country(ARGV[0])
