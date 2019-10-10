require 'nokogiri'
require 'pry'
require 'open-uri'



def get_all_url
	
	puts "détermination des adresses url en cours"

	base = "http://annuaire-des-mairies.com"

	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	noko_o = page.xpath("//a[@class='lientxt']")
	#end_url =  noko_o[n].values[1].map {
	array_url =  noko_o.map { |n| n.values[1].delete_prefix ('.')}.map{ |n| n= base + n} 
	
	puts "adresses url colléctées"

	return array_url
	
end

def get_all_name

	puts "scrapping des noms en cours"
 
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	noko_o = page.xpath("//a[@class='lientxt']")
	array_name = noko_o.map { |n| n.text}

	puts "scrapping des noms terminé"

	return array_name

end

def get_one_mail (url)

	page = Nokogiri::HTML(open(url))   
	noko_o = page.xpath("//section[2]/div/table/tbody/tr[4]/td[2]")
	return noko_o.text

end

def get_all_mail

	
	

	array_url = get_all_url

	puts "scrapping des mails en cours"

	array_mail = []
	array_url.size.times do |url|

		array_mail << get_one_mail(array_url[url])
		if (url % 10 == 0) && (url != 0) then
			puts "#{url} mails scrappés"
		end
	end

	puts "scrapping des mails terminés"

	return array_mail

end

def create_hash (name, mail)
	return	hash = {name => mail}
end

def create_array_hash (array_name, array_mail) 
	
	puts "création du tableau de hash en cours"

	array_hash = []
	array_name.size.times do |n|
		array_hash << create_hash(array_name[n], array_mail[n])
	end

	puts "création du tableau de hash terminée"
	return array_hash

end

def display_array_hash(array_hash)
	puts "affichage des données"
	puts array_hash
end


def scrapper
	
	array_name = get_all_name
	array_mail = get_all_mail
	array_hash = create_array_hash(array_name, array_mail)
	return array_hash

end


def perform
	
	display_array_hash(scrapper)

end

perform