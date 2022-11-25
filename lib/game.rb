require_relative 'messages'
require_relative 'display'
# 
# menu -> new game -> load dictionary/code -> gameplay loop -> result?
class Game
  include Messages
  def initialize(code = '', chances = 7, progress = [])
    @code = code
    @chances = chances
    @progress = progress
    @display = nil
  end
  
  def menu
    puts message_intro
    puts message_menu
    input = gets.chomp
    if input == '1'
      # new game
      @code = select_random_word[0]
      @chances = 7
      @progress = Array.new(@code.length){'_'}
      @display = Display.new(@code, @progress)
      gaming
    elsif input == '2'
      # load game
    elsif input == '3'
      # quit game
      puts message_quit
    else
      puts message_invalid_input
      menu
    end
  end

  def select_random_word
    words = File.readlines('google-10000-english-no-swears.txt', chomp: true)
    words.select! do |word|
      true if (5..12).include? word.length 
    end
    return words.sample(1)
  end

  def guess_input_check(input)
    input.length == 1 && input.match?(/[a-z]{1}/)
  end

  def gaming
    puts message_gameplay
    puts message_chance_left (@chances)
     puts @code
     @display.on_screen
    puts "  (Length of word is #{@code.length})"
    input = gets.chomp.downcase
    gaming unless guess_input_check(input)

  end
  

end

Game.new.menu