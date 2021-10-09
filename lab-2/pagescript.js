import Deck from "./card.js"

//Create a new deck and shuffle it
const deck = new Deck();
deck.shuffle();

var currentPlayer = ''; // 'playerA' or 'playerB'
var playerAScore = 0;
var playerBScore = 0;
var playerAButton = false;
var playerBButton = false;

//Display the values on the initial twelve cards
var initialCards = document.querySelectorAll('button.card');
for (var i = 0; i < initialCards.length; i++) {
  initialCards[i].innerHTML = `${deck.cards[i].color}\n${deck.cards[i].shape}\n${deck.cards[i].shading}\n${deck.cards[i].number}`;
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
