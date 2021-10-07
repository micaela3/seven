var currentPlayer = ''; // 'player1' or 'player2'

document.getElementById('cards').addEventListener('click', function(event) {
  if (event.target.nodeName === 'BUTTON') {
    window.alert(event.target.innerHTML);
  }
});

document.getElementById('players').addEventListener('click', function(event) {
  if (event.target.nodeName === 'BUTTON') {
      event.target.style.color = 'green';
      event.target.style.fontSize = 'large';
      if (event.target.id === 'player1') {
        currentPlayer = 'player1';
      } else {
        currentPlayer = 'player2';
      }

  }
});
