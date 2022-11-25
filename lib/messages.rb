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

  def message_gameplay
    "Submit your guesses by entering a single valid character."
  end

  def message_chance_left (chance)
    return "You have #{chance} chances left" if chance > 1
    return "This is your last chance!" if chance == 1
  end
end