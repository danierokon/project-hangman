require_relative 'game'
require_relative 'display'
require_relative 'messages'

def play_game
  Game.new.menu  
end

play_game