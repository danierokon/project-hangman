
class Display
  def initialize(code, progress, guessed_char)
    @code = code
    @progress = progress
    @guessed_char = guessed_char
  end

  def on_screen
    @progress.each {|char| print char + " "}
  end

  def guessed
    if @guessed_char[0].nil?
      return ''
    else      
      list = @guessed_char.join(' ')
      return "These are the letters you guessed: #{list}"
    end
  end
end