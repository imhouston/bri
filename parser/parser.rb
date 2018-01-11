require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'securerandom'

URL = 'http://da-mart.ru'
PRODUCTS_LIMIT = 10
IMAGE_PATH = 'images/'

=begin
class Parser
  def initialize(url = 'http://da-mart.ru/')
    @agent = Mechanize.new

  end
end
=end

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
    pages_count = []
    subcategories << [subcat.text, subcat[:href]]
  end
  subcategories
end

def get_products_from_page(page, products_list, category, subcategory = nil)
  subcategory = category if subcategory.nil?

  page.css('#catalog-content td').each do |product|
    product_name = product.at_css('.name').text
    image_link = product.at_css('.pic img')[:src]
    image_name =  "#{SecureRandom.uuid}.png"
    @agent.get(image_link).save(IMAGE_PATH + image_name) unless image_link.include?('no_img')
    products_list << [name: product_name, category: category, subcategory: subcategory]
  end

  products_list
end



def get_products(products = [])
  return products if products.size > PRODUCTS_LIMIT

end

cat = get_categories(catalog_link)
page = @agent.get("#{URL}#{cat[1][:path]}")
products = []
products = get_products_from_page(page, products, cat[1][:name])

p products[1]

