require_relative 'game'
require_relative 'display'
require_relative 'messages'

include Messages

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

def menu
  puts message_intro
  puts message_menu
  input = gets.chomp
  if input == '1'
    # new game
    Game.new().new_game
  elsif input == '2'
    # load game
    Game.new().load_game
  else
    puts message_invalid_input
    menu
  end
end

def play_game
  menu
  replay_check
end

play_game