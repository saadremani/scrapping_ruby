require 'nokogiri'
require 'pry'
require 'open-uri'


def get_data

	array_of_data = []
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   
	array_link_name = page.xpath("//tbody/tr/td/a[@class='text-left col-symbol']")
	array_link_price = page.xpath("//tbody/tr/td/a[@class='price']")
	array_of_data[0] = array_link_name
	array_of_data[1] = array_link_price
	
	
	return array_of_data

end

def get_all_name
	
	puts "scrapping des noms en cours"
	
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))  
	noko_o = page.xpath("//tbody/tr/td[@class='text-left col-symbol']")
	array_name = noko_o.map { |n| n.text}

	puts "scrapping des noms terminé"

	return array_name

end

def get_all_price

	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))  
	noko_o = page.xpath("//tbody/tr/td/a[@class='price']")
	array_price = noko_o.map { |n| n.text.delete_prefix('$').to_f}
	return array_price

end

def	create_hash(name, price)
	
	hash = { name => price}
	return hash

end

def create_array_hash(array_name, array_price)
	
	array_hash = []
	array_name.size.times do |n|
		
		hash = create_hash(array_name[n], array_price[n])
		array_hash << hash
	
	end

	return array_hash

end

def display_array_hash(array_hash)
	puts array_hash
end

def crypto_scrapper

	array_name = get_all_name
	array_price = get_all_price
	array_hash = create_array_hash(array_name, array_price)
	return array_hash

end


def perform
	display_array_hash(crypto_scrapper)
end

perform