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
var numCardsOnTable = 0;
var totalCardsOut = 0;
var numRows = 3;

console.log(deck.cards);

//Display the values on the initial twelve cards
var initialCards = document.querySelectorAll('button.card');
for (var i = 0; i < initialCards.length; i++) {
  numCardsOnTable++;
  totalCardsOut++;
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
        playerAButton = true;
        currentPlayer = 'playerA';
      } else { //if playerA is on, turn it off
        event.target.style.color = 'black';
        playerAButton = false;
      }
    } else {
      if (playerBButton == false) { //if playerB is off, turn it on
        event.target.style.color = 'green';
        playerBButton = true;
        currentPlayer = 'playerB';
      } else { //if playerB is on, turn it off
        event.target.style.color = 'black';
        playerBButton = false;
      }
    }
  }
});

// adding event listeners for hint button, draw cards button, and submit set guess button
// document.getElementById('hintButton').addEventListener('click', hint);
document.getElementById('moreCardsButton').addEventListener('click', drawCards);

function drawCards(event) {
  if (numCardsOnTable == 21) {
    alert("You can't have more than 21 cards out at a time!")
  } else if (deck.cards[80].shape.length === 1) {
       alert("There are no more cards in the deck!")
  } else {
    // Find a <table> element with id="myTable":
    var table = document.getElementById("cards");
    // Create an empty <tr> element and add it to the 1st position of the table:
    var row = table.insertRow(numRows);
    numRows++;
    // Add some text to the new cells:
    var index = 0;
    for (var cardsOnTable = numCardsOnTable; numCardsOnTable < cardsOnTable + 3; i++) {
      var tableCell = row.insertCell(index);
      // tableCell.setAttribute('id', 'newCard');
      tableCell.setAttribute('id', `card${totalCardsOut}`)
      tableCell.classList.add("card");
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
          tableCell.style.fontSize = 'extra large';
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
      tableCell.classList.add(`${deck.cards[i].color}`);
      tableCell.innerHTML = "Card".concat(totalCardsOut);
      for (var j = 0; j < deck.cards[i].number; j++) {
        tableCell.innerHTML = tableCell.innerHTML.concat(`<br>${deck.cards[i].shape}\n`);
      }
      index++;
      numCardsOnTable++;
      totalCardsOut++;
    }
  }
};

function removeCard(ID) {
  let cardElement = document.getElementById(ID);
  console.log(ID);
  cardElement.remove();
  numCardsOnTable--;
}

/*function replaceCards(cardNum) {
  let cardElement = document.getElementById('card'+ cardNum);
  cardElement.innerHTML = deck.cards[numCardsOnTable+1];
}*/

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
  var card1 = deck.cards[document.getElementById('choice1').value];
  var card2 = deck.cards[document.getElementById('choice2').value];
  var card3 = deck.cards[document.getElementById('choice3').value];

  console.log(card1, card2, card3);

  var isValid = isValidSet(card1, card2, card3);

  // If valid, increment the appropriate player's score
  if (isValid) {
    let scoreElement = document.getElementById(currentPlayer + 'Score');
    let currentScore = parseInt(scoreElement.innerHTML);

    // Check if score is 3. If so, this player wins.
    if (currentScore == 2) {
      alert(`${currentPlayer} has won the game!`);
      window.location.reload();
      return;
    }
    currentScore += 1;
    scoreElement.innerHTML = currentScore;

    // Remove cards that were chosen
    removeCard('card' + document.getElementById('choice1').value);
    removeCard('card' + document.getElementById('choice2').value);
    removeCard('card' + document.getElementById('choice3').value);

    // Replace the chosen cards
    //replaceCard(document.getElementById('choice1').value);
    drawCards(event);

  } else {
    alert("That was not a valid set!");
  }

  // Clear the text fields
  document.getElementById('choice1').value = '';
  document.getElementById('choice2').value = '';
  document.getElementById('choice3').value = '';

  // Reset the player selection button back to default appearance
  document.getElementById(currentPlayer).style.color = 'black';

  // Set currentPlayer back to none (empty string)
  currentPlayer = '';
}

