require './card.rb'
require 'colorize'

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

# Print the given array of cards in an easily-read table, one attribute per column
def display_cards(cards)
  puts
  cards.each_with_index do |card, index|
    card_color = ""
    card_color = :light_red if card.color == "red"
    card_color = :light_green if card.color == "green"
    card_color = :light_magenta if card.color == "purple"
    print "#{index}\t", "#{card.color}".colorize(card_color), "\t#{card.number}\t#{card.shape}    \t#{card.shading}\n"

  end
end


# Main game code
puts "Game Started"
deck = create_deck
playerA_score = 0
playerB_score = 0

# Randomly pick 12 cards from the deck
totalCard = 0
dealt_cards = []

  # Deal 12 cards to the table
  while totalCard < 12 
    item = deck.sample
    dealt_cards << deck.delete(item)
    totalCard = totalCard + 1
  end

  # Display the 12 drawn cards
  display_cards dealt_cards

  # Prompt the user to choose three cards then determine if they are a set
  MAXCARDS = 21
  gameOver = false
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
      elsif dealt_cards.length == MAXCARDS
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
        # Print out three new random cards from the deck
        for i in 0..2
          item = deck.sample
          dealt_cards << deck.delete(item)
          totalCard = totalCard + 1
        end
        display_cards dealt_cards
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
      playerID = ""
      # Remove the player ID from the input
      until playerID == "A" || playerID == "B"
        playerID = (input.slice!(0)).upcase
        if playerID != "A" && playerID != "B"
          puts "ERROR: Make sure to enter either 'A' or 'B' before your set to indicate your player ID!"
          input = gets.chomp
        end
      end
      nums = input.split(',')
      nums.map!(&:to_i)
      #output error message if the user input less or more than 3 card numbers
      if nums.length != 3
        puts "ERROR: Make sure to enter exactly three card numbers with commas separating them!"
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
          display_cards dealt_cards

          # Display current player scores
          puts "\nPlayer A score: #{playerA_score}"
          puts "Player B score: #{playerB_score}"
          puts "There are #{deck.length} cards in the deck!"
        end
      end
    end
  end

