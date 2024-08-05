class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.all
  end

  def check_answer
    puzzle = Puzzle.find(params[:id])
    if puzzle.answer.downcase == params[:answer].downcase
      render json: { correct: true, reveal_text: puzzle.reveal_text }
    else
      render json: { correct: false }
    end
  end
end
