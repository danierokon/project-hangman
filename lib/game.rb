require_relative 'messages'
require_relative 'display'
require 'json'
#
# menu -> new game -> load dictionary/code -> gameplay loop -> result?
class Game
  include Messages
  def initialize(code = '', chances = 7, progress = [], guessed_char = [])
    @code = code
    @chances = chances
    @progress = progress
    @guessed_char = guessed_char # guessed =/= progress as they can be wrong
    @display = nil
  end

  def new_game
    @code = select_random_word[0]
    @chances = 7
    @progress = Array.new(@code.length) { '_' }
    @display = Display.new(@code, @progress, @guessed_char)
    gaming
  end

  def load_game
    puts message_choose_save_slots
    slot = slot_input_check
    if slot_exist?(slot)
      from_json(slot)
      gaming
    else
      puts message_no_save_found
    end
  end

  def save_game
    puts message_choose_save_slots
    slot = slot_input_check
    to_json(slot)
  end

  def slot_input_check
    # only 1/2/3 allowed
    input = gets.chomp
    return input if %w[1 2 3].include?(input)

    puts message_invalid_input
    slot_input_check
  end

  def slot_exist?(slot)
    File.exist?("saves/#{slot}.json")
  end

  def to_json(slot = '1')
    path = "saves/#{slot}.json"
    File.open(path, 'w') do |save|
      JSON.dump({
                  code: @code,
                  chances: @chances,
                  progress: @progress,
                  guessed_char: @guessed_char
                }, save)
    end
  end

  def from_json(slot)
    path = "saves/#{slot}.json"
    save = File.open(path, 'r')
    data = JSON.load(save)
    @code = data['code']
    @chances = data['chances']
    @progress = data['progress']
    @guessed_char = data['guessed_char']
    @display = Display.new(@code, @progress, @guessed_char)
  end

  def select_random_word
    words = File.readlines('google-10000-english-no-swears.txt', chomp: true)
    words.select! do |word|
      true if (5..12).include? word.length
    end
    words.sample(1)
  end

  def guess_input_check(input)
    if input == 'save'
      save_game
      puts message_save_game
      return true
    end
    if input.length == 1 && input.match?(/[a-z]{1}/)
      if @guessed_char.include?(input)
        puts message_dupe_guess
        false
      else
        @guessed_char.push(input) unless @guessed_char.include?(input)
        true
      end
    else
      puts message_invalid_input
      false
    end
  end

  def update_progress(input)
    code_array = @code.split('')
    @chances -= 1 unless code_array.include? input
    code_array.each_with_index do |char, index|
      @progress[index].replace(char) if char == input
    end
  end

  def game_status_check(input)
    if @progress.include?('_') == false
      puts message_win
      return true
    end
    if @chances == 0
      puts message_lost
      return true
    end
    return unless input == 'save'

    true
  end

  def gaming
    game_over = false
    until game_over == true
      puts message_save_tips
      puts message_gameplay
      puts message_chance_left(@chances)
      # puts @code
      @display.on_screen
      puts "  (Length of word is #{@code.length})"
      puts @display.guessed
      input = gets.chomp.downcase
      next unless guess_input_check(input)

      update_progress(input)
      game_over = game_status_check(input)
    end
    return if input == 'save'

    print 'You guessed : '
    @display.on_screen
    puts "\n" + message_reveal(@code)
  end
end
