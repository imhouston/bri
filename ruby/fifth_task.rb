require 'csv'
require 'ipaddr'

class IpToCountry
  def initialize
    @data = CSV.read('IpToCountry.csv', row_sep: "\n", skip_lines: /^#/, encoding: 'windows-1251:utf-8',
      headers: ['from', 'to', '2', '4', 'Cntr_symbol', 'Cntry', 'Country'])
  end

  def code_ip_address(ip)
    IPAddr.new(ip).to_i
  end

  def determine_country(ip)
    ip_code = code_ip_address(ip)

    index = @data['from'].bsearch_index { |x| ip_code - x.to_i }
    return @data['Cntr_symbol'][index] unless index.nil?

    raise 'Не найден такой ip'
  end
end

puts IpToCountry.new.determine_country(ARGV[0])
