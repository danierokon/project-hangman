require_relative 'game'
require_relative 'display'
require_relative 'messages'

include Messages

def play_game
  Game.new.menu
  replay_check
end

def replay_check
  input = gets.chomp.downcase
  case input
  when 'y'
    play_game
  when 'n'
    puts message_quit
  else
    puts message_invalid_input
    replay_check
  end
end

play_game