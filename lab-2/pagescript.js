import Deck from "./card.js"

const TRIANGLES = ["▲", "◭", "△"];
const CIRCLES = ["●", "◐", "○"];
const SQUARES = ["■", "◧", "□"];

//Create a new deck and shuffle it
const deck = new Deck();
deck.shuffle();

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
  initialCards[i].innerHTML = "";
  for (var j = 0; j < deck.cards[i].number; j++) {
    initialCards[i].innerHTML = initialCards[i].innerHTML.concat(`${deck.cards[i].shape}\n`); 
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



console.log('test');
