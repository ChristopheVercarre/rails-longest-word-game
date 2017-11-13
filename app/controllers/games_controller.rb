require 'open-uri'

class GamesController < ApplicationController

  MESSAGE = { 1 => "A disaster!",
            2 => "Not really good.",
            3 => "Well done.",
            4 => "Well done.",
            5 => "Well done!",
            6 => "Well done!",
            7 => "Well done!",
            8 => "Well done!",
            9 => "Well done! Top result." }

  def game
    @alphabet = ("A".."Z").to_a
    @grid = @alphabet.sample(9).join.upcase
  end

  def score
    @grid = params[:grid]
    @word = params[:word]
    @letters = @word.upcase.split(//)
    @message=""

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @word_attempt = open(url).read
    @word_data = JSON.parse(@word_attempt)
    @found_word = @word_data["found"]

    @letters_included = @letters.all? { |letter| @word.count(letter) <= @grid.count(letter) }

    if @found_word && @letters_included
      return @message = MESSAGE[@letters.length]
    elsif @letters_included
      return @message = "Word is not in the grid."
    else
      @message = "Not an english word."
    end
  end
end
