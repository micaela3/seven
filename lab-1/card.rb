class Card
  attr_reader :color
  attr_reader :number
  attr_reader :shape
  attr_reader :shading

  def initialize(color, number, shape, shading)
    @color = color
    @number = number
    @shape = shape
    @shading = shading
  end
  
  # Class method to verify if a set is a set or not
  def self.valid_set?(card1, card2, card3)
    cards_arr = [card1, card2, card3]
    
    unless (card1.color == card2.color && card2.color == card3.color) || (card1.color != card2.color && card1.color != card3.color && card2.color != card3.color)
      return false
    end

    unless (card1.number == card2.number && card2.number == card3.number) || (card1.number != card2.number && card1.number != card3.number && card2.number != card3.number)
      return false
    end
      
    unless (card1.shape == card2.shape && card2.shape == card3.shape) || (card1.shape != card2.shape && card1.shape != card3.shape && card2.shape != card3.shape)
      return false
    end
    
    unless (card1.shading == card2.shading && card2.shading == card3.shading) || (card1.shading != card2.shading && card1.shading != card3.shading && card2.shading != card3.shading)
      return false
    end

    true

  end

end
