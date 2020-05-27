class Scraper
    
    BASE_URL = "https://www.loc.gov/programs/national-film-preservation-board/film-registry/complete-national-film-registry-listing/"

    def self.scrape_prize
        doc = Nokogiri::HTML(open(BASE_URL))
        film_table = doc.css('tbody').css('tr')
        film_table.each do |entry| 
            film = Film.new
            film.name = entry.css('th').text
            film.year = entry.css('td')[0].text
            film.induction_year = entry.css('td')[1].text
        end 
    end 

end 
