require 'clue'

describe Clue do 
    before do 
        Clue.all.clear()
        new_clue = Hash["question" => "How many folds does a chef's hat have?", "answer" => 100, "wrong_answers" => [90, 115, 50]]
        @first_clue = Clue.new
        @first_clue.question = new_clue['question']
        @first_clue.answer = new_clue['answer'] 
        @first_clue.wrong_answers = new_clue['wrong_answers']
        @first_clue.all_answers = [new_clue['answer']].concat(new_clue['wrong_answers'])
    end 

    describe "wrong answers" do 
        it "includes an array of wrong answers" do 
            expect(@first_clue.wrong_answers.class).to eq(Array)
        end 
    end 

    describe "question" do 
        it "includes a question " do 
            expect(@first_clue.question).to eq("How many folds does a chef's hat have?")
        end 
    end 
    
    describe "all" do 
        it "is added to all" do 
            expect(Clue.all.size).to eq(1)
        end
    end 

    describe "all answers" do 
        it "includes wrong answers" do 
            expect(@first_clue.all_answers).to include(@first_clue.wrong_answers[0])
        end 
    end 
end 