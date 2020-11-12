class Menu 
    @@counter = 0
    @@score = 0
    @@questions = []

    def run 
        # initialize Clue class with trivia JSON file
        Clue.get_trivia
        puts
        puts
        puts Rainbow("WELCOME!").magenta
        puts "Let's put your trivia knowledge to the test!"
        sleep 1
        puts
        puts "Each game consists of ten multiple choice questions."
        puts "At any point, you can exit the game by entering " + Rainbow("'quit'").red + "."
        puts "Just enter " + Rainbow("'start'").green + " to play."
        get_input
    end 

    def get_input 
        input = gets.chomp.downcase
        if input == "quit"
            quit 
        elsif input == "start"
            puts
            start_game
        else 
            puts Rainbow("Please enter a valid input").red
            puts
            get_input 
        end 
    end 

    def start_game
        # reset all variables
        @@counter = 0
        @@score = 0

        # create an array of ten unique random numbers
        # these will be indicies of clues in Clue.all array
        randoms = Set.new
        while randoms.size < 10 
            randoms.add(rand(0..19))
        end
        @@questions = randoms.to_a

        puts Rainbow("LET'S GO!").aqua
        next_question
    end 

    def next_question
        # find question index
        # after each question, index 0 is removed, so next question is always at index 0
        i = @@questions[0]
        @@counter += 1

        # sort & randomize answers
        answers = Clue.all[i].all_answers.shuffle
        correct_idx = answers.index(Clue.all[i].answer)

        puts Rainbow("#{@@counter}. #{Clue.all[i].question}").blue
        sleep 1
        answers.each_with_index{|item, idx| puts "#{idx + 1}. #{item}"}
        puts Rainbow("Choose the number next to the answer you think is correct.").magenta

        check_answer(correct_idx, i)
    end

    def is_valid(entry)
        if entry == 'quit'
            quit
        end 
        valids = [1, 2, 3, 4]
        if valids.include?(entry.to_i)
            return true
        else
            return false
        end 
    end 

    def check_answer(answer, idx)
        input = gets.chomp.downcase
        # only check valid inputs
        if is_valid(input)
            input = input.to_i() - 1
            answer = answer.to_i()
            if input == answer
                puts Rainbow("You are correct!").green
                puts 
                @@score += 1 
            else 
                puts Rainbow("That's not correct.").red
                puts "The correct answer is: " + Rainbow("#{answer + 1}. #{Clue.all[idx].answer}").cyan
                puts 
            end
            puts "Your current score is " + Rainbow("#{@@score}/10") 
            puts
            
            # determine if this is the final question
            # could also be @@questions.empty?
            if @@counter >= 10
                tally_score
            else 
                @@questions.shift()
                next_question
            end 
        else 
            puts Rainbow("Please enter a valid input.").red
            puts 
            check_answer(answer, idx)
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
        puts "Want to play again? Just enter " + Rainbow("'start'.").green
        puts "Or " + Rainbow("'quit'").red + " to exit."
        get_input
    end

    def quit
        puts "Thanks for playing!"
        puts
        exit
    end 

end 