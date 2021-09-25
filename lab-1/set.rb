require "./card.rb"

def create_deck
  deck = []

  colors = ["red", "green", "purple"]
  numbers = [1, 2, 3]
  shapes = ["diamond", "squiggle", "oval"]
  shadings = ["solid", "striped", "open"]

  colors.each do |color|
    numbers.each do |number|
      shapes.each do |shape|
        shadings.each do |shading|
          deck << Card.new(color, number, shape, shading)
        end
      end
    end
  end

  deck
end

# Finds a set in the array of cards passed in. Borrowed from https://github.com/teixeir3/Ruby-SetGame/blob/master/lib/board.rb
def find_set(cards)
  cards.combination(3).to_a.find {|x,y,z| Card.valid_set?(x,y,z)} || false
end


# Main game code
puts "Game Started"
deck = create_deck
playerA_score = 0
playerB_score = 0

# Randomly pick 12 cards from the deck
totalCard = 0
dealt_cards = []

  while totalCard < 12 
    item = deck.sample
    puts "#{totalCard}\t#{item.color}\t#{item.number}\t#{item.shape}    \t#{item.shading}"
    dealt_cards << deck.delete(item)
    totalCard = totalCard + 1
  end

# Prompt the user to choose three cards then determine if they are a set
  gameOver = false
  maxCards = 21
  puts "\nEnter the indices of three cards that make a set."
  puts "Player A, type your anwer as \"A #,#,#\""
  puts "Player B, type your anwer as \"B #,#,#\""
  puts "If you see no valid sets, enter 'n' to recieve three more cards."
  puts "If you need help, enter 'h' to view a hint."
  until gameOver == true
    input = gets.chomp
    if input == "n"
      #if there are no more cards in the deck, the game is over
      if deck.length == 0
        puts "Sorry there are no more cards. Game Over!"
        gameOver = true
      elsif dealt_cards.length == maxCards
        puts "\nSorry, you can only have 21 cards out at a time!"
        puts "Would you like to keep looking for a set? (Enter 'y' to keep looking or 'n' to end the game)."
        keepPlaying = ""
        until keepPlaying == "y" || keepPlaying == "n"
          keepPlaying = gets.chomp
          if keepPlaying == "n"
            puts "Game Over!"
            gameOver = true
          elsif keepPlaying != "y"
            puts "Please enter either 'y' or 'n' to keep playing or quit."
          end
        end
      else
        #reprint out all the cards from the previous round
        dealt_cards.each_with_index do |card, index|
          puts "#{index}\t#{card.color}\t#{card.number}\t#{card.shape}    \t#{card.shading}"
        end
        #print out three new random cards from the deck
        for i in 0..2
          item = deck.sample
          puts "#{totalCard}\t#{item.color}\t#{item.number}\t#{item.shape}    \t#{item.shading}"
          dealt_cards << deck.delete(item)
          totalCard = totalCard + 1
        end
      end
    elsif input == "h"
      set = find_set(dealt_cards)
      if set
        puts "There is a card that forms a set with cards #{dealt_cards.find_index(set[0])} and #{dealt_cards.find_index(set[1])}. Good luck!"
      else
        puts "There are no valid sets. Press 'n' to draw more cards! If you still can't find a set, the game is over!"
      end
    else
      #if string was not 'n' or 'h', make a string only containing numbers the user input, convert to array
      playerID = input.slice! 0   # Remove the player ID from input while also recording which player found the set
      nums = input.split(',')
      #numsArr = nums.scan(/\w/)
      nums.map!(&:to_i)
      #output error message if the user input less or more than 3 card numbers
      if nums.length != 3
        puts "ERROR: Make sure to enter exactly three card numbers!"
      else
        validSet = Card.valid_set?(dealt_cards[nums[0]], dealt_cards[nums[1]], dealt_cards[nums[2]])
        puts "\nCorrect. Good Job, Player #{playerID}!" if  validSet
        puts "\nIncorrect. Not a valid set. Try again!" if !validSet
        puts
        if validSet
                # Replace the cards that were selected
          if dealt_cards.length <= 12
            for i in 0..2
              item = deck.sample
              dealt_cards[nums[i]] = deck.delete(item)
            end
          else  # Remove the cards that were selected
            for i in 0..2
              card = dealt_cards[nums[i]]
              dealt_cards.delete(card)  
            end
          end

          # Add 1 to the score of the player who found the set
          playerA_score += 1 if playerID == "A"
          playerB_score += 1 if playerID == "B"
          puts "Invalid player ID entered; score not counted" if playerID != "A" && playerID != "B"

          #reprint out all the cards from the previous round
          dealt_cards.each_with_index do |card, index|
            puts "#{index}\t#{card.color}\t#{card.number}\t#{card.shape}    \t#{card.shading}"
          end

          # Display current player scores
          puts "\nPlayer A score: #{playerA_score}"
          puts "Player B score: #{playerB_score}"
        end
      end
    end
  end

#deck.each {|card| puts card.color, card.number, card.shape, card.shading, "\n"}

#puts Card.valid_set?(Card.new("red", 1, "diamond", "solid"), Card.new("red", 1, "diamond", "striped"), Card.new("red", 1, "diamond", "open"))
