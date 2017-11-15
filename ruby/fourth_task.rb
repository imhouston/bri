class LCD
  TOP_LCD_PART = {
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
  }.freeze

  CENTRAL_LCD_PART = {
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
  }.freeze

  BOTTOM_LCD_PART = {
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
  }.freeze

  def digit_to_lcd(digits)
    lcd_digit = ['', '', '']

    digits.each_char do |d|
      lcd_digit[0] << TOP_LCD_PART[d.to_i]
      lcd_digit[1] << CENTRAL_LCD_PART[d.to_i]
      lcd_digit[2] << BOTTOM_LCD_PART[d.to_i]
    end

    lcd_digit.each { |v| puts v }
  end
end

LCD.new.digit_to_lcd(ARGV[0])
