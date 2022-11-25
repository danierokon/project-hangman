module Messages    
  # "\e[31m#{self}\e[0m" red text
  def message_intro
    "Hello, welcome to Hangman! (without man to hang)"
  end

  def message_quit
    "Goodbye!"
  end

  def message_menu
    "1. New Game\n2. Load Game\n3. Quit"
  end

  def message_invalid_input
    "\e[31m#{"Invalid input!"}\e[0m"
  end

  def message_dupe_guess
    "\e[31m#{"You already guessed that letter!\nTry something else!"}\e[0m"
  end

  def message_gameplay
    "Submit your guesses by entering a single valid character."
  end

  def message_chance_left (chance)
    return "You have #{chance} chances left" if chance > 1
    return "\e[31m#{"This is your last chance!"}\e[0m" if chance == 1
  end

  def message_win
    "\e[35m#{'You win!'}\e[0m"
  end

  def message_lost
    "\e[31m#{'No more chances, you lost!'}\e[0m"
  end

  def message_reveal(code)
    "The secret word is #{code}!"
  end

  def message_back_to_menu
    "Press enter to go back to menu."
  end
end