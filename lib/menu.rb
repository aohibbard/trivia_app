class Menu 
    @@counter = 0
    @@score = 0
    @@questions = []

    def run 
        Clue.get_trivia
        puts Rainbow("WELCOME!").magenta
        puts "This trivia program helps you put your trivia knowledge to the test"
        puts "so you can rise to the top in any Slack group, pub quiz, or Trivial Pursuit game"
        sleep 1
        puts "Each game consists of ten multiple choice questions"
        puts "At any point, you can exit the game by entering " + Rainbow("quit").red
        puts "Just enter " + Rainbow("'start'").green + " to play."
        get_input
    end 

    def get_input 
        input = gets.chomp.downcase
        if input == "quit"
            quit 
        elsif input == "start"
            # Quiz.get_trivia
            puts
            start_game
        else 
            puts Rainbow("Please enter a valid input").red
            puts
            get_input 
        end 
    end 

    def start_game
        @@counter = 0
        @@score = 0
        randoms = Set.new
        while randoms.size < 10 
            randoms.add(rand(0..19))
        end
        @@questions = randoms.to_a
        next_question
    end 

    def next_question
        # find question index
        i = @@questions[0]
        @@counter += 1

        # sort & randomize answers
        answers = Clue.all[i].all_answers.shuffle
        correct_idx = answers.index(Clue.all[i].answer)

        puts Rainbow("#{@@counter}.").magenta + " #{Clue.all[i].question}"
        sleep 1
        answers.each_with_index{|item, idx| puts "#{idx}. #{item}"}
        puts Rainbow("Choose the number next to the answer you think is correct.").magenta

        check_answer(correct_idx)
    end 

    def check_answer(answer)
        input = gets.chomp.downcase
        if input == 'quit'
            quit
        else
            input = input.to_i()
            answer = answer.to_i()
            if input == answer
                puts Rainbow("You are correct!").green
                puts ""
                @@score += 1 
            else 
                puts Rainbow("That's not correct.").red
                puts "The correct answer is #{answer}"
                puts ""
            end
            if @@counter >= 10
                tally_score
            else 
                @@questions.shift()
                next_question
            end 
        end
    end 

    def tally_score
        puts "You scored #{@@score}/10."
        sleep 1
        if @@score < 4
            puts "You might want to hit the books."
        elsif @@score >= 4 && @@score < 7
            puts "You did okay."
        elsif @@score >= 7 && @@score < 10
            puts "Great job!"
        elsif @@score == 10
            puts "Perfect score!"
        end 
        puts "Want to play again? Just enter 'start'."
        puts "Or quit to exit."
        get_input
    end

    def quit
        puts "Thanks for playing!"
        exit
    end 

end 