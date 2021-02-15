class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    @letters = []
    # Itero 10 vezes para gerar letras aleatorias
    10.times do
      @letters.push(('A'..'Z').to_a.sample)
    end
  end

  def score
    # Recebo a palavra do usuario
    @word = params[:word].upcase
    @letters = params[:letters].split
    # Defino a resposta
    @score = ''
    # Busco na API jogando a palavra digitada
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    # Faco o Parsing
    dictionary_serialized = open(url).read
    dictionary = JSON.parse(dictionary_serialized)

    # Se os caracteres da palavra digitada estiverem inclusas no letters...
    if @word.split('').all? { |w| @letters.include?(w) }
      case dictionary['found']
      # Verifica se a palavra digitada for falsa
      when false
        @score = "Sorry but #{@word.capitalize} does not seem to be a valid English word."
      # Verifico se a palavra digitada for verdadeira
      when true
        @score = "Congratulations! #{@word.capitalize} is a valid English word!"
      end
    # ...Se nao estiverem inclusas no letters
    else
      @score = "Sorry but #{@word.capitalize} can't be built out of #{@letters}"
    end
  end
end
