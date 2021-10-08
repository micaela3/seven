var currentPlayer = ''; // 'playerA' or 'playerB'
var playerAScore = 0;
var playerBScore = 0;
var playerAButton = false;
var playerBButton = false;

document.getElementById('cards').addEventListener('click', function (event) {
  if (event.target.nodeName === 'BUTTON') {
    window.alert(event.target.innerHTML);
  }
});

document.getElementById('players').addEventListener('click', function (event) {
  if (event.target.nodeName === 'BUTTON') {
    if (event.target.id === 'playerA') {
      if (playerAButton == false) {
        event.target.style.color = 'green';
        event.target.style.fontSize = 'large';
        playerAButton = true;
        currentPlayer = 'playerA';
      } else {
        event.target.style.color = 'black';
        event.target.style.fontSize = 'small'
        playerAButton = false;
      }
    } else {
      if (playerBButton == false) {
        event.target.style.color = 'green';
        event.target.style.fontSize = 'large';
        playerBButton = true;
        currentPlayer = 'playerB';
      } else {
        event.target.style.color = 'black';
        event.target.style.fontSize = 'small'
        playerBButton = false;
      }
    }
  }
});

console.log('test');
