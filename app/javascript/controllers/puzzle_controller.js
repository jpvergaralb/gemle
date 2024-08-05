import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="puzzle"
export default class extends Controller {
  static targets = ["input", "revealText"]

  check(event) {
    event.preventDefault();
    const puzzleId = event.currentTarget.dataset.puzzleId;
    const input = this.inputTargets.find(input => input.dataset.puzzleId === puzzleId);
    const revealText = this.revealTextTargets.find(revealText => revealText.dataset.puzzleId === puzzleId);
    const answer = input.value.trim();

    if (answer) {
      fetch("/check_answer", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content
        },
        body: JSON.stringify({ id: puzzleId, answer: answer })
      })
      .then(response => response.json())
      .then(data => {
        if (data.correct) {
          revealText.textContent = data.reveal_text;
          revealText.classList.remove("hidden");
        } else {
          alert("Incorrect answer. Try again!");
        }
      });
    }
  }
}
