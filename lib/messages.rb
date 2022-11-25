module Messages
  # "\e[31m#{self}\e[0m" red text
  def message_intro
    'Hello, welcome to Hangman! (without man to hang)'
  end

  def message_quit
    'Goodbye!'
  end

  def message_menu
    "1. New Game\n2. Load Game"
  end

  def message_invalid_input
    "\e[31mInvalid input!\e[0m"
  end

  def message_dupe_guess
    "\e[31mYou already guessed that letter!
Try something else!\e[0m"
  end

  def message_gameplay
    'Submit your guesses by entering a single valid character.'
  end

  def message_chance_left(chance)
    return "You have #{chance} chances left" if chance > 1
    return "\e[31mThis is your last chance!\e[0m" if chance == 1
  end

  def message_win
    "\e[35mYou win!\e[0m"
  end

  def message_lost
    "\e[31mNo more chances, you lost!\e[0m"
  end

  def message_reveal(code)
    "The secret word is #{code}!"
  end

  def message_replay
    'New game? (y/n)'
  end

  def message_choose_save_slots
    'Choose a save slot (1/2/3)'
  end

  def message_save_game
    'Game saved!'
  end

  def message_no_save_found
    'No save file in destinated slot exists.'
  end

  def message_save_tips
    "\e[36m#{"You can save the game's state by inputting 'save'"}\e[0m"
  end
end
