class Film
    
    attr_accessor :name, :year, :induction_year, :url, :desc
    @@all = []

    def initialize
        @@all << self 
    end 

    def self.all
        @@all 
    end 

    def self.scrape_bio
        url = "https://www.loc.gov/programs/national-film-preservation-board/film-registry/descriptions-and-essays/"
        film = CLI.selection
        doc = Nokogiri::HTML(open(url))
        body = doc.css('article')
        if !!doc.at_css("p:contains('#{film.name}')")
            film.desc = doc.at_css("p:contains('#{film.name}')").text.strip
        else 
            film.desc = "No description available"
        end 
        if !!doc.at_css("p:contains('#{film.name}')").css('a').attribute('href')
            film.url = "https://www.loc.gov" +  doc.at_css("p:contains('#{film.name}')").css('a').attribute('href')
        end 
    end 




    def self.search(query)
        term = query.downcase.strip
        @@find_movie = @@all.select{|movie| movie.name.downcase == term}
    end 

    def self.find_by_idx(idx_input)
        film = @@all[idx_input]
    end 

end 

