
class Display
  def initialize(code, progress)
    @code = code
    @progress = progress
  end

  def on_screen
    screen = @progress.each {|char| print char + " "}
  end
end