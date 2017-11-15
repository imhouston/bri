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

    left = -1
    right = @data.size

    while left < right - 1
      middle = (left + right) / 2

      if @data['from'][middle].to_i < ip_code
        left = middle
      else
        right = middle
      end
    end

    return @data['Cntr_symbol'][right] if @data['from'][right] == ip_code.to_s

    raise 'Не найден такой ip'
  end
end

puts IpToCountry.new.determine_country(ARGV[0])
