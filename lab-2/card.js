class Card {
  constructor(color, number, shape, shading) {
    this.color = color
    this.number = number
    this.shape = shape
    this.shading = shading
  }

  isValidSet(card1, card2, card3) {
    cardArr = [card1, card2, card3]

    if (!(card1.color === card2.color && card2.color === card3.color) || !(card1.color !== card2.color && card1.color !== card3.color && card2.color != card3.color)) {
      return false;
    }
    if (!(card1.number === card2.number && card2.number === card3.number) || !(card1.number !== card2.number && card1.number !== card3.number && card2.number != card3.number)) {
      return false;
    }
    if (!(card1.shape === card2.shape && card2.shape === card3.shape) || !(card1.shape !== card2.shape && card1.shape !== card3.shape && card2.shape != card3.shape)) {
      return false;
    }
    if (!(card1.shading === card2.shading && card2.shading === card3.shading) || !(card1.shading !== card2.shading && card1.shading !== card3.shading && card2.shading != card3.shading)) {
      return false;
    }

    return true;
  }
}

module.exports = Card