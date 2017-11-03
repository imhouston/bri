class LCD
  def initialize
    @top_hashes = {
      1 => '   ',
      2 => ' _ ',
      3 => ' _ ',
      4 => '   ',
      5 => ' _ ',
      6 => ' _ ',
      7 => ' _ ',
      8 => ' _ ',
      9 => ' _ ',
      0 => ' _ '
    }

    @mid_hashes = {
      1 => ' | ',
      2 => ' _|',
      3 => ' _|',
      4 => '|_|',
      5 => '|_ ',
      6 => '|_ ',
      7 => '  |',
      8 => '|_|',
      9 => '|_|',
      0 => '| |'
    }

    @bot_hashes = {
      1 => ' | ',
      2 => '|_ ',
      3 => ' _|',
      4 => '  |',
      5 => ' _|',
      6 => '|_|',
      7 => '  |',
      8 => '|_|',
      9 => ' _|',
      0 => '|_|'
    }
  end

  def digit_to_lcd(digit)
    top = ''
    mid = ''
    bot = ''
    digit.each_char do |d|
      top << @top_hashes[d.to_i]
      mid << @mid_hashes[d.to_i]
      bot << @bot_hashes[d.to_i]
    end
    lcd_value = []
    lcd_value << top
    lcd_value << mid
    lcd_value << bot
    lcd_value.each { |v| puts v }
  end
end

LCD.new.digit_to_lcd(ARGV[0])
