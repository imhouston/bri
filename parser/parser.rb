require 'mechanize'
require 'securerandom'

URL = 'http://da-mart.ru'
PRODUCTS_LIMIT = 1500
IMAGE_PATH = 'images/'
CATALOG_FILE_PATH = 'catalog.txt'

@agent = Mechanize.new
catalog_link = @agent.get(URL).link_with(href: '/catalog/')

def get_categories(catalog_link)
  categories = []
  page = catalog_link.click
  page.css('#catalog-main-content .name').each do |cat|
    categories.push(name: cat.text, path: cat[:href], subcategories: get_subcategories(cat[:href]))
  end

  categories
end

def get_subcategories(category_link)
  subcategories = []
  page = @agent.get("#{URL}#{category_link}")
  page.css('#catalog-main-content .name').each do |subcat|
    subcategories.push(name: subcat.text, path: subcat[:href])
  end

  subcategories
end

def get_products_from_page(page, products_list, category, subcategory = nil)
  subcategory = category if subcategory.nil?

  page.css('#catalog-content td').each do |product|
    product_name = product.at_css('.name')
    next if product_name.nil?

    product_uuid = SecureRandom.uuid
    image_link = product.at_css('.pic img')[:src]

    unless image_link.include?('no_img')
      image_name = "#{product_uuid}.jpg"
      @agent.get(image_link).save(IMAGE_PATH + image_name)
    end

    products_list.push(
      name: product_name.text,
      category: category,
      subcategory: subcategory,
      image: image_name,
      uuid: product_uuid
    )
  end

  products_list
end

def get_products(catagory_list)
  products = []
  catagory_list.each do |category|
    if category[:subcategories].empty?
      walk_pages(category, products)

    else
      category[:subcategories].each do |subcategory|
        walk_pages(category, subcategory, products)
      end
    end

    break if products.size > PRODUCTS_LIMIT
  end

  products
end

def walk_pages(category, subcategory = category, products_list)
  cur_page = @agent.get("#{URL}#{subcategory[:path]}")

  loop do
    return if products_list.size > PRODUCTS_LIMIT

    get_products_from_page(cur_page, products_list, category[:name], subcategory[:name])

    break if cur_page.link_with(text: '>').nil?
    cur_page = cur_page.link_with(text: '>').click
  end
end

def parse_to_file(products)
  products.each do |product|
    File.open(CATALOG_FILE_PATH, 'a+') do |file|
      file.puts("Группа\t#{product[:category]}")
      file.puts("Подгруппа\t#{product[:subcategory]}")
      file.puts("Название\t#{product[:name]}")
      product[:image].nil? ? file.puts("Фото\tОтсутствует") : file.puts("Фото\t#{product[:image]}")
      file.puts("Идентификатор товара\t#{product[:uuid]}")
    end
  end
end

def get_statistic(products)
  # группировка по подгруппам, так до след. группы больше 5к товаров. Загружать 5к?
  products.group_by { |product| product[:subcategory] }.each do |subcategory|
    puts "#{subcategory[0]} - #{subcategory[1].size}"
  end

  count_with_image = products.select { |product| product[:image] }.count
  puts "Процент товаров с фото: #{count_with_image.to_f / products.count * 100}%"

  images_with_sizes = []
  kbyte = 2**10
  sum_images_size = Dir["#{IMAGE_PATH}*.jpg"].inject(0) do |sum_size, filename|
    size = (File.size(filename).to_f / kbyte).round(2)
    images_with_sizes.push(name: filename, size: size)
    sum_size + size
  end

  min_image = images_with_sizes.min_by { |image| image[:size] }
  max_image = images_with_sizes.max_by { |image| image[:size] }

  puts "Минимульное изображение: #{min_image[:name]} - #{min_image[:size]} KB"
  puts "Максимальное изображение: #{max_image[:name]} - #{max_image[:size]} KB"
  puts "Средний размер изображения: #{sum_images_size.to_f / images_with_sizes.size} KB"
end

categories = get_categories(catalog_link)
test = get_products(categories)

parse_to_file(test)
get_statistic(test)
