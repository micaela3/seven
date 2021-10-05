const Card = require('./card.js');
const fs = require('fs');
const { table } = require('console');
const readline = require('readline');
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function createDeck() {
  deck = new Array;

  var colors = ['red' , 'green', 'purple'];
  var numbers = [1, 2, 3];
  var shapes = ['diamond', 'squiggle', 'oval']
  var shadings = ['solid', 'striped', 'open']

  colors.forEach(function(color) {
    numbers.forEach(function(number) {
      shapes.forEach(function(shape) {
        shadings.forEach(function(shading) {
          deck.push(new Card(color, number, shape, shading));
        });
      });
    });
  });

  return deck;
}

// Taken from https://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
function shuffle(array) {
  let currentIndex = array.length,  randomIndex;

  // While there remain elements to shuffle...
  while (currentIndex != 0) {

    // Pick a remaining element...
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // And swap it with the current element.
    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex], array[currentIndex]];
  }

  return array;
  }

function displayCards(cards) {
  for (var index = 0; index < cards.length; index++) {
      console.log(`${index}\t${cards[index].color}\t${cards[index].number}\t${cards[index].shape}    \t${cards[index].shading}`);
    }
}

/*=========================
        Main Code 
===========================*/
// Create and shuffle the full card deck
var deck = createDeck();
shuffle(deck);

// Deal the first 12 cards of the shuffled array to the table
var tableCards = new Array(12);
for (var i = 0; i < 12; i++) {
  tableCards[i] = deck.shift();
}
displayCards(tableCards);

var gameOver = false;
const maxCards = 21;

console.log('\nEnter the indices of three cards that make a set.');
console.log('Player A, type your choice as "A #,#,#');
console.log('Player B, type your choice as "B #,#,#');
console.log('If you se no valid sets, enter "n" to receive three more cards.');
console.log('If you need help, enter "h" to view a hint.');
