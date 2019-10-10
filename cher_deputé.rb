require 'nokogiri'
require 'pry'
require 'open-uri'



def get_all_first_name

	puts "scrapping des noms en cours"
 
	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	noko_o = page.xpath("//ul[@class='col3']/li/a")
	array_first_name = noko_o.map { |n| n.text}.map { |n| n.split(' ')}.map{ |n| n[1]}
	#array_last_name = array_last_name.map { |n| n.split(' ')}.map{ |n| n[1]}
	
	puts "scrapping des noms terminé"

	return array_first_name

end

def get_all_last_name

	puts "scrapping des noms en cours"
 
	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	noko_o = page.xpath("//ul[@class='col3']/li/a")
	array_last_name = noko_o.map { |n| n.text}.map { |n| n.split(' ')}.map{ |n| if n.size <= 3 then n[2] else n[2] + ' ' + n[3] end}
		

	#array_last_name = array_last_name.map { |n| n.split(' ')}.map{ |n| n[1]}
	
	puts "scrapping des noms terminé"

	return array_last_name

end


def get_all_url
	
	puts "détermination des adresses url en cours"

	base = "http://www2.assemblee-nationale.fr"

	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	noko_o = page.xpath("//ul[@class='col3']/li/a")
	#end_url =  noko_o[n].values[1].map {
	#array_url =  noko_o.map { |n| n.values[1].delete_prefix ('.')}.map{ |n| n= base + n} 
	#array_url =  noko_o[0].values[0]
	array_url =  noko_o.map { |n| base + n.values[0]}
	puts "adresses url colléctées"

	return array_url
	
end

def get_one_mail (url)

	page = Nokogiri::HTML(open(url))   
	noko_o = page.xpath("//dl[@class='deputes-liste-attributs']/dd[4]/ul/li[2]/a")
	return noko_o.text

end

def get_all_mail


	array_url = get_all_url

	puts "scrapping des mails en cours"

	array_mail = []
	#100.times do |url|
	array_url.size.times do |url|

		array_mail << get_one_mail(array_url[url])
		if (url % 10 == 0) && (url != 0) then
			puts "#{url} mails scrappés"
		end
	end

	puts "scrapping des mails terminés"

	return array_mail

end

def create_hash (first_name,last_name, mail)
	return	hash = {"first_name" => first_name,
									"last_name" => last_name,
									"email" => mail}
end

def create_array_hash (array_first_name, array_last_name, array_mail) 
	
	puts "création du tableau de hash en cours"

	array_hash = []
	array_first_name.size.times do |n|
		array_hash << create_hash(array_first_name[n],array_first_name[n], array_mail[n])
	end

	puts "création du tableau de hash terminée"
	return array_hash

end


def display_array_hash(array_hash)
	puts "affichage des données"
	puts array_hash
end

def scrapper

	array_first_name = get_all_first_name
	array_last_name = get_all_last_name
	array_mail = get_all_mail
	array_hash = create_array_hash(array_first_name, array_last_name, array_mail)
	return array_hash

end


def perform
	

	display_array_hash(scrapper)

end

perform