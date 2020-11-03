require 'clue'

describe Clue do 
    before do 
        # @first_clue = Clue.new(:wrong_answers => ['90', '115', '50'])
        @first_clue = Clue.new(:question => "How many folds does a chef's hat have?", :answer => 100, :wrong_answers => [90, 115, 50])
    end 

    describe "wrong answers" do 
        it "includes an array of wrong answers" do 
            expect(@first_clue.wrong_answers.class).to eq(Hash || Array)
        end 
    end 

    describe "question" do 
        it "includes a question " do 
            expect(@first_clue.question).to eq("How many folds does a chef's hat have?")
        end 
    end 
    
    describe "all" do 
        it "is added to all" do 
            expect(Clue.all[0]).to eq(@first_clue)
        end
    end 
end 