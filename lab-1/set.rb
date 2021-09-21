class Card

  def initialize(color, number, shape, shading)
    @color = color
    @number = number
    @shape = shape
    @shading = shading
  end

end

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

deck = create_deck
puts deck.length
