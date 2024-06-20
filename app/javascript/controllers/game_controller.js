import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game"
export default class extends Controller {
  // these are elements that we expect to interact with
  static targets = ["guessesRemaining", "attemptsList", "guessForm", "guessInput", "attemptButton", "submitButton"]

  // This is called immediately after the controller is connected to the DOM
  connect() {
    this.attempts = []
    this.maxAttempts = 5
    this.gameStatus = 'in_progress'
    this.gemstoneName = this.element.dataset.gameGemstoneName  
    this.gameDate = this.element.dataset.gameDate
    this.gameNumber = this.element.dataset.gameNumber
    this.checkGameDate()
    this.loadGameState();
  }

  checkGameDate() {
    const storedDate = localStorage.getItem('gameDate');
    if (storedDate !== this.gameDate){
      localStorage.gameState = null;
      localStorage.gameDate = this.gameDate;
    }
  }

  submitGuess(event) {
    event.preventDefault();
    if (this.gameStatus !== 'in_progress') return;

    const guess = this.guessInputTarget.value.trim();
    if (guess) {
      this.attempts.push({
        guess,
        correct: guess.toLowerCase() === this.gemstoneName.toLowerCase()
      })
      this.updateGameState();
    }
    this.guessInputTarget.value = '';
  }

  updateGameState() {
    if (this.attempts.length >= this.maxAttempts) {
      this.gameStatus = 'lost';
    } else if (this.attempts[this.attempts.length - 1].correct) {
      this.gameStatus = 'won';
    }

    this.renderAttempts()
    this.saveGameState()
    this.saveGameHistory()
    this.updateAttemptButtons();

    if (this.gameStatus !== 'in_progress') {
      this.disableInput();
    }

    if (this.gameStatus === 'won') {
      this.guessesRemainingTarget.textContent = 'Correct!';
    } else if (this.gameStatus === 'lost') {
      this.guessesRemainingTarget.textContent = `You lost! The gem was ${this.gemstoneName}`;
    }
  }

  renderAttempts() {
    this.attemptsListTarget.innerHTML = ''
    this.attempts.forEach((attempt) => {
      const attemptElement = document.createElement('div');
      attemptElement.className = 'flex items-center justify-between bg-gray-700 p-2 rounded mb-2 w-3/4'
      attemptElement.innerHTML = `
        <span>${attempt.guess}</span>
        <span class="${attempt.correct ? 'text-green-500' : 'text-red-500'}">${attempt.correct ? '✔' : '❌'}</span>
      `
      this.attemptsListTarget.appendChild(attemptElement);
    })
  }

  saveGameState() {
    const gameState = {
      attempts: this.attempts,
      gameStatus: this.gameStatus
    }
    localStorage.setItem('gameState', JSON.stringify(gameState));
  }

  loadGameState() {
    const gameState = JSON.parse(localStorage.getItem('gameState'));
    if (gameState) {
      this.attempts = gameState.attempts || [];
      this.gameStatus = gameState.gameStatus || 'in_progress';
      this.renderAttempts();
      this.updateAttemptButtons(); 
      if (this.gameStatus !== 'in_progress') {
        this.disableInput();
      }
    }
  }

  saveGameHistory() {
    const games = JSON.parse(localStorage.getItem('games')) || {};
    games[this.gameNumber] = {
      status: this.gameStatus,
      attempts: this.attempts
    };
    localStorage.setItem('games', JSON.stringify(games));
  }

  updateAttemptButtons() {
    this.attemptButtonTargets.forEach((button, index) => {
      if (index < this.attempts.length) {
        button.textContent = this.attempts[index].correct ? '✔' : '❌';
        button.classList.remove('bg-slate-800');
        button.classList.add(this.attempts[index].correct ? 'bg-green-500' : 'bg-red-500');
      } 
    });
  }

  disableInput() {
    this.guessInputTarget.disabled = true;
    this.submitButtonTarget.disabled = true;
    this.guessInputTarget.placeholder = 'thank you for playing';
    this.submitButtonTarget.classList.add('cursor-not-allowed', 'bg-gray-500');
    this.submitButtonTarget.classList.remove('hover:bg-green-400')
  }
}
