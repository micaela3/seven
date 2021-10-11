const COLORS = ["red", "green", "purple"];
const NUMBERS = ["1", "2", "3"];
const SHAPES = ["triangle", "circle", "square"];
const SHADING = ["solid", "half", "open"];

class Deck {
  constructor(cards = newDeck()) {
    this.cards = cards
  }

  // Taken from https://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
  shuffle() {
    let currentIndex = this.cards.length, randomIndex;
    // While there remain elements to shuffle...
    while (currentIndex != 0) {
      // Pick a remaining element...
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex--;
      // And swap it with the current element.
      [this.cards[currentIndex], this.cards[randomIndex]] = [
        this.cards[randomIndex], this.cards[currentIndex]];
    }
  }
}

class Card {
  constructor(color, number, shape, shading) {
    this.color = color
    this.number = number
    this.shape = shape
    this.shading = shading
  }
}

//Create a full new deck of 81 cards
function newDeck() {
  return COLORS.flatMap(color => {
    return NUMBERS.flatMap(number => {
      return SHAPES.flatMap(shape => {
        return SHADING.map(shading => {
          return new Card(color, number, shape, shading);
        })
      })
    })
  })
}

function isValidSet(card1, card2, card3) {
  cardArr = [card1, card2, card3]

  if ((card1.color === card2.color && card2.color === card3.color) || (card1.color !== card2.color && card1.color !== card3.color && card2.color !== card3.color)) {
    return true;
  }
  if ((card1.number === card2.number && card2.number === card3.number) || (card1.number !== card2.number && card1.number !== card3.number && card2.number !== card3.number)) {
    return true;
  }
  if ((card1.shape === card2.shape && card2.shape === card3.shape) || (card1.shape !== card2.shape && card1.shape !== card3.shape && card2.shape !== card3.shape)) {
    return true;
  }
  if ((card1.shading === card2.shading && card2.shading === card3.shading) || (card1.shading !== card2.shading && card1.shading !== card3.shading && card2.shading !== card3.shading)) {
    return true;
  }

  return false;
}

// function used in find_set as a predicate function for the filter function
function isValidSetArray(elt, index, array) {
  var card1 = array[0];
  var card2 = array[1];
  var card3 = array[2];

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

