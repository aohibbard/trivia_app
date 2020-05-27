class CLI

    @@selection = nil 

    def self.selection
        @@selection 
    end 

    def run 
        Scraper.scrape_prize
        menu 
        get_first_input 
    end 

    def menu 
        puts 
        puts Rainbow("WELCOME!").magenta
        puts "The National Film Registry selects 25 films each year showcasing the range and diversity of American film heritage to increase awareness for its preservation."
        sleep 1
        puts
        puts "To learn about the Film Registry, type " + Rainbow("'about'.").aqua
        sleep 1 
        puts "To see films by induciton year, enter" + Rainbow(" 'induction year'.").aqua
        sleep 1 
        # puts "To search for a film by title, enter" + Rainbow(" 'search'.").aqua
        # puts "To see film by year of induction, enter a year between " + Rainbow("1989").aqua + " and " + Rainbow("the present year.").aqua
        # sleep 1
        puts "To exit, type 'exit'."
    end

    def about
        sleep 1
        puts "Established by the National Film Preservation Act of 1988, the National Film Preservation Board works to ensure the survival, conservation and increased public availability of America's film heritage, including:"
        puts "-advising the Librarian on its recommendations for annual selections to the National Film Registry,"
        puts "-apprising the Librarian of changing trends and policies in the field of film preservation,"
        puts "-and counseling the Librarian on ongoing implementation of the National Film Preservation Plan."
        sleep 2
        puts "To search films by induction year, enter" + Rainbow(" 'induction year'.").aqua 
        get_first_input
    end 

    def get_first_input 
        input = gets.chomp
        if input == "about"
            about 
        elsif input == "induction year" || input == "more"
            search_by_class
        elsif input == "search"
            search_by_title
        elsif input == "exit"
            outro 
        else  
            puts "Please enter a valid input"
            get_first_input 
        end 
    end

    def search_by_class
        puts "Please enter a year between 1989 and #{Time.now.year - 1}"
        search_induction
    end

    def search_induction 
        input = gets.chomp.to_i 
        if input >= 1989 && input <=  ( Time.now.year - 1 ) 
            display_films(input)
        elsif input.downcase == "exit"
            outro
        else 
            puts "Please enter a valid input"
            get_first_input 
        end 
    end 

    def search_by_title 
        puts "Please enter a title"
        search_film
        puts 
    end 

    def search_film
        title = gets.chomp.downcase.strip
        movie = Film.search(title)
        if !movie.empty?
            index = Film.all.index{|x| x.name.downcase == title}
            @@selection = Film.find_by_idx(index)
            Film.scrape_bio
            show_movie(@@selection)
        else 
            puts "That film is not in the registry"
            puts "You can nominate a film for the registry here: https://www.loc.gov/programs/national-film-preservation-board/film-registry/nominate/"
            sleep 1
            puts ""
            puts Rainbow("Search for another movie").pink
            puts ""
            search_by_title
        end 
    end 

    def display_films(year)
        puts 

        puts "The films for #{year} are:"
        Film.all.each.with_index(1) do |film, i|
            if film.induction_year == year.to_s #or maybe year_to_i (check how passed)
                puts "#{i}." + Rainbow(" #{film.name}").magenta + " #{film.year}"  
            end 
        end 
        ask_for_film_idx
    end 

    def ask_for_film_idx
        puts "To learn more about a film , enter the " + Rainbow("number").aqua + " next to its title."
        puts 
        input = " "
        input = gets.strip.to_i - 1 
            if input < 0 || input > Film.all.size 
                puts "Please enter a valid input."
            elsif input == "exit"
                outro 
            else
                @@selection = Film.find_by_idx(input) 
                Film.scrape_bio
                show_movie(@@selection)
            end 
        puts
    end 

    def show_movie(movie)
        puts Rainbow(movie.name).yellow
        puts "Released in #{movie.year}"
        puts "Inducted in #{movie.induction_year}"
        puts movie.desc 
        if movie.url
            puts ""
            puts "For more information on this film, visit"
            puts movie.url 
        end 
        puts ""
        puts "Please enter " + Rainbow("'more'").aqua + " if you would like to learn about other films."
        get_first_input
    end 

    # made redundant by redirecting to get_first_input
    def keep_running
        user_input = gets.downcase.strip 
        if user_input == "more"
            search_by_class 
        elsif user_input == "exit"
            outro
        else 
            "Please enter a valid input"
            keep_running
        end 
    end 

    def outro
        puts 
        puts "Thanks for learning about the National Film Registry."
        puts ""
        sleep 1 
        exit 
    end 

end 