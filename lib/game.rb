require_relative 'messages'
require_relative 'display'
require 'json'
# 
# menu -> new game -> load dictionary/code -> gameplay loop -> result?
class Game
  include Messages
  def initialize(code = '', chances = 7, progress = [], guessed_char = Array.new)
    @code = code
    @chances = chances
    @progress = progress
    @guessed_char = guessed_char #guessed =/= progress as they can be wrong
    @display = nil
  end
  
  def new_game
    @code = select_random_word[0]
    @chances = 7
    @progress = Array.new(@code.length){'_'}
    @display = Display.new(@code, @progress, @guessed_char)
    gaming
  end
  
  def load_game
    puts "load game temp"
  end

  def save_game

  end

  def self.to_json(string)

  end

  def self.from_json(string)

  end

  def select_random_word
    words = File.readlines('google-10000-english-no-swears.txt', chomp: true)
    words.select! do |word|
      true if (5..12).include? word.length 
    end
    return words.sample(1)
  end

  def guess_input_check(input)    
    if input.length == 1 && input.match?(/[a-z]{1}/)      
      if @guessed_char.include?(input)
        puts message_dupe_guess
        return false
      else
        @guessed_char.push(input) unless @guessed_char.include?(input)
        return true
      end
    else
      puts message_invalid_input
      return false
    end
  end

  def update_progress(input)
    code_array = @code.split('')
    @chances -= 1 unless code_array.include? input
    code_array.each_with_index do |char, index|
      if char == input
        @progress[index].replace(char)
      end
    end
  end

  def game_status_check    
    if @progress.include?('_') == false
      puts message_win
      return true
    end
    if @chances == 0
      puts message_lost
      return true
    end
  end

  def gaming
    game_over = false
    until game_over == true
      puts message_gameplay
      puts message_chance_left (@chances)
        puts @code
      @display.on_screen      
      puts "  (Length of word is #{@code.length})"
      puts @display.guessed
      input = gets.chomp.downcase
      next unless guess_input_check(input)
      update_progress(input)
      game_over = game_status_check
    end
    print 'You guessed : '
    @display.on_screen
    puts "\n" + message_reveal(@code)    
    puts message_replay
  end

end
