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

  var colors = ['red', 'green', 'purple'];
  var numbers = [1, 2, 3];
  var shapes = ['diamond', 'squiggle', 'oval']
  var shadings = ['solid', 'striped', 'open']

  colors.forEach(function (color) {
    numbers.forEach(function (number) {
      shapes.forEach(function (shape) {
        shadings.forEach(function (shading) {
          deck.push(new Card(color, number, shape, shading));
        });
      });
    });
  });

  return deck;
}

// Taken from https://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
function shuffle(array) {
  let currentIndex = array.length, randomIndex;

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

// combos is an array of arrays of cards and will hold all possible combinations of 3 cards from tableCards
function findAllCombos(cards){
  var combos = [];
  for (var i = 0; i < cards.length; i++){
    for (var j = i + 1; j < cards.length; j++){
      for (var k = j+1; k < cards.length; k++){
        combos.push([ cards[i], cards[j], cards[k] ]);
      }
    }
  }
  return combos;
}

// returns an array of length 3 where each element is a Card in a valid set
function findSet(cards) {
  var set = []; // set will be an array of arrays
  var combos = findAllCombos(cards); // combos is array of arrays of cardsi
  // set will be all the arrays in combos such that the array is a valid set
  set = combos.filter(Card.isValidSetArray);
  if (set.length > 0){
    return set[0]; // return first valid set; this will be an array of Cards
  }else{
    return false; // no valid sets
  }
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
var totalTableCards = 0;
var playerA_score = 0;
var playerB_score = 0;
shuffle(deck);

// Deal the first 12 cards of the shuffled array to the table
var tableCards = new Array(12);
for (var i = 0; i < 12; i++) {
  tableCards[i] = deck.shift();
  totalTableCards = totalTableCards + 1;
}
displayCards(tableCards);

var gameOver = false;
const maxCards = 21;

console.log('\nEnter the indices of three cards that make a set.');
console.log('Player A, type your choice as "A #,#,#');
console.log('Player B, type your choice as "B #,#,#');
console.log('If you se no valid sets, enter "n" to receive three more cards.');
console.log('If you need help, enter "h" to view a hint.');

while (gameOver == false) {
  if (/*user clicks button for three more cards*/) {
    if (deck.length == 0) {
      window.alert('Sorry there are no more cards. Game Over!');
      gameOver = true;
    } else if (tableCards.length == maxCards) {
      window.alert('\nSorry, you can only have 21 cards out at a time!');
      window.alert('Would you like to keep looking for a set?');
      if (/*the user click yes*/) {
        console.log("The game is continued.");
      } else if (/* the user click no*/) {
        gameOver == true;
        console.log("\nGame Over! The final score is:");
        console.log("Player A score:" + playerA_score);
        console.log("Player B score:" + playerB_score);
        if (playerA_score > playerB_score) {
          console.log("Player A wins!");
        } else if (playerB_score > playerA_score) {
          console.log("Player B wins!");
        } else {
          console.log("The game ends in a draw!");
        }
      }
    } else {
      for (var i = 0; i <= 2; i++) {
        totalTableCards = totalTableCards + 1;
        tableCards[totalTableCards] = deck.shift();
      }
      displayCards(tableCards);
    }
  } else if (/*user clicks hint*/) {
    //finish creating findSet method and use it to see if there is a valid set
    set = find_set(tableCards);
    // set will contain either boolean false or array of Card objects
    if (set){
      var index1 = tableCards.indexOf(set[0]);
      var index2 = tableCards.indexOf(set[1]);
      console.log("There is a card that forms a set with cards " + index1 + " and " + index2 + ". Good luck!");
    }else{
      window.alert("There are no valid sets. Press 'draw' to draw more cards! If you still can't find a set, the game is over!");
    }
  } else { //insert code for when the player chooses a set

  }
}
