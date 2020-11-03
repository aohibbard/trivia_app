class Clue

    attr_accessor :question, :answer, :wrong_answers, :all_answers
    @@all = []

    def initialize(wrong_answers)
        @question = question
        @answer = answer
        @wrong_answers = wrong_answers
        @@all << self
    end
    
    def self.all 
        @@all
    end 

    def self.get_trivia
        json = JSON.parse(File.read("Apprentice_TandemFor400_Data.json"))
        json.each do |res| 
            clue = Clue.new 
            clue.question = res['question']
            clue.answer = res['correct']
            clue.wrong_answers = res['incorrect']
            clue.all_answers = [res['correct']].concat(res['incorrect'])
        end
    end 

end 