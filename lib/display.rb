class Display
  def initialize(code, progress, guessed_char)
    @code = code
    @progress = progress
    @guessed_char = guessed_char
  end

  def on_screen
    @progress.each { |char| print char + ' ' }
  end

  def guessed
    return '' if @guessed_char[0].nil?

    list = @guessed_char.join(' ')
    "These are the letters you guessed: #{list}"
  end
end
