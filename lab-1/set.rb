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


# Main game code
puts "Game Started"
deck = create_deck

# Randomly pick 12 cards from the deck
totalCard = 0
temp = []

  while totalCard < 12 
    item = deck.sample
    puts "#{totalCard}  #{item.color}, #{item.number}, #{item.shape}, #{item.shading}"
    temp << deck.delete(item)
    totalCard = totalCard + 1
  end

# Prompt the user to choose three cards then determine if they are a set
  gameOver = false
  maxCards = 21
  until gameOver == true
    puts "\nEnter three card numbers (numbers on far left of each row, with commas in between each number) that make a set."
    puts "If you see no valid sets, enter 'n' to recieve three more cards."
    input = gets.chomp
    if input == "n"
      #if there are no more cards in the deck, the game is over
      if deck.length == 0
        puts "Sorry there are no more cards. Game Over!"
        gameOver = true
      elsif temp.length == maxCards
        puts "Sorry, you can only have 21 cards out at a time!"
      else
        #reprint out all the cards from the previous round
        temp.each_with_index do |card, index|
          puts "#{index}  #{card.color}, #{card.number}, #{card.shape}, #{card.shading}"
        end
        #print out three new random cards from the deck
        for i in 0..2
          item = deck.sample
          puts "#{totalCard}  #{item.color}, #{item.number}, #{item.shape}, #{item.shading}"
          temp << deck.delete(item)
          totalCard = totalCard + 1
        end
      end
    else
      #if string was not 'n', make a string only containing numbers the user input, convert to array
      nums = input.split(',')
      #numsArr = nums.scan(/\w/)
      nums.map!(&:to_i)
      #output error message if the user input less or more than 3 card numbers
      if nums.length != 3
        puts "ERROR: Make sure to enter exactly three card numbers!"
      else
        validSet = Card.valid_set?(temp[nums[0]], temp[nums[1]], temp[nums[2]])
        puts validSet
        if validSet
          if temp.length <= 12
            for i in 0..2
              item = deck.sample
              temp[nums[i]] = deck.delete(item)
            end
          else
            temp.delete_at(nums[0])  
            temp.delete_at(nums[1])  
            temp.delete_at(nums[2])  
          end

          #reprint out all the cards from the previous round
          temp.each_with_index do |card, index|
            puts "#{index}  #{card.color}, #{card.number}, #{card.shape}, #{card.shading}"
          end
        end
      end
    end
  end

#deck.each {|card| puts card.color, card.number, card.shape, card.shading, "\n"}

#puts Card.valid_set?(Card.new("red", 1, "diamond", "solid"), Card.new("red", 1, "diamond", "striped"), Card.new("red", 1, "diamond", "open"))
