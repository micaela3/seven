var currentPlayer = ''; // 'playerA' or 'playerB'
var playerAScore = 0;
var playerBScore = 0;

document.getElementById('cards').addEventListener('click', function(event) {
  if (event.target.nodeName === 'BUTTON') {
    window.alert(event.target.innerHTML);
  }
});

document.getElementById('players').addEventListener('click', function(event) {
  if (event.target.nodeName === 'BUTTON') {
      event.target.style.color = 'green';
      event.target.style.fontSize = 'large';
      if (event.target.id === 'playerA') {
        currentPlayer = 'playerA';
      } else {
        currentPlayer = 'playerB';
      }

  }
});

console.log('test');