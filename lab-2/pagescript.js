const TRIANGLES = ["▲", "◭", "△"];
const CIRCLES = ["●", "◐", "○"];
const SQUARES = ["■", "◧", "□"];

//Create a new deck and shuffle it
const deck = new Deck();
deck.shuffle();

console.log(deck.cards);

var currentPlayer = ''; // 'playerA' or 'playerB'
var playerAScore = 0;
var playerBScore = 0;
var playerAButton = false;
var playerBButton = false;

console.log(deck.cards);

//Display the values on the initial twelve cards
var initialCards = document.querySelectorAll('button.card');
for (var i = 0; i < initialCards.length; i++) {
  switch (deck.cards[i].shape) {
    case "triangle":
      if (deck.cards[i].shading === "solid") {
        deck.cards[i].shape = TRIANGLES[0];
      } else if (deck.cards[i].shading === "half") {
        deck.cards[i].shape = TRIANGLES[1];
      } else {
        deck.cards[i].shape = TRIANGLES[2];
      }
      break;
    case "circle":
      initialCards[i].style.fontSize = 'extra large';
      if (deck.cards[i].shading === "solid") {
        deck.cards[i].shape = CIRCLES[0];
      } else if (deck.cards[i].shading === "half") {
        deck.cards[i].shape = CIRCLES[1];
      } else {
        deck.cards[i].shape = CIRCLES[2];
      }
      break;
    case "square":
      if (deck.cards[i].shading === "solid") {
        deck.cards[i].shape = SQUARES[0];
      } else if (deck.cards[i].shading === "half") {
        deck.cards[i].shape = SQUARES[1];
      } else {
        deck.cards[i].shape = SQUARES[2];
      }
  }
  initialCards[i].classList.add(`${deck.cards[i].color}`);
  // initialCards[i].innerHTML = "";
  for (var j = 0; j < deck.cards[i].number; j++) {
    initialCards[i].innerHTML = initialCards[i].innerHTML.concat(`<br>${deck.cards[i].shape}\n`);
  }
}

document.getElementById('cards').addEventListener('click', function (event) {
  if (event.target.nodeName === 'BUTTON') {
    window.alert(event.target.innerHTML);
  }
});

document.getElementById('players').addEventListener('click', function (event) {
  if (event.target.nodeName === 'BUTTON') {
    if (event.target.id === 'playerA') {
      //if playerA is off, turn it on
      if (playerAButton == false) {
        event.target.style.color = 'green';
        event.target.style.fontSize = 'large';
        playerAButton = true;
        currentPlayer = 'playerA';
      } else { //if playerA is on, turn it off
        event.target.style.color = 'black';
        event.target.style.fontSize = 'small'
        playerAButton = false;
      }
    } else {
      if (playerBButton == false) { //if playerB is off, turn it on
        event.target.style.color = 'green';
        event.target.style.fontSize = 'large';
        playerBButton = true;
        currentPlayer = 'playerB';
      } else { //if playerB is on, turn it off
        event.target.style.color = 'black';
        event.target.style.fontSize = 'small'
        playerBButton = false;
      }
    }
  }
});



// adding event listeners for hint button, draw cards button, and submit set guess button
// document.getElementById('hintButton').addEventListener('click', hint);
// alter set.js so that hint is its own function instead of in while loop

// document.getElementById('moreCardsButton').addEventListener('click', drawMore);
// alter set.js so that drawMore is its own function instead of in while loop

document.getElementById('submitSetButton').addEventListener('click', submitSetGuess);
// alter set.js so that submitSetGuess is its own function instead of in while loop

/* submitSetGuess would be a function that calls other functions to:
 *1.  check whether the input values in the textfields form a valid set
 * (get player's guesses from text fields by var cardNum1 = document.getElementById("card1").value;
 *2.  update the score if needed
 *3.  deal more cards if needed*/
function submitSetGuess(event) {
  // Get the cards that were entered by user in text fields
  var card1 = deck.cards[document.getElementById('card1').value];
  var card2 = deck.cards[document.getElementById('card2').value];
  var card3 = deck.cards[document.getElementById('card3').value];

  var isValid = isValidSet(card1, card2, card3);

  // If valid, increment the appropriate player's score
  if (isValid) {
    let currentScore = parseInt(document.getElementById(currentPlayer).innerHTML)
    currentScore += 1;
    document.getElementById(currentPlayer + 'score').innerHTML = currentScore;
  }

  // Set currentPlayer back to none (empty string)
  currentPlayer = '';

  // Clear the text fields
  document.getElementById('card1').value = '';
  document.getElementById('card2').value = '';
  document.getElementById('card3').value = '';
}

console.log('test');
