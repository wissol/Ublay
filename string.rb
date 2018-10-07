
class String

  def tail 
    self[1..-1]
  end

  def last_char 
    self[-1]
  end 
  
  def first_char 
    self[0]
  end

  def first_word 
    self.split(" ").head
  end

  def fake_type
    if self.size > 0
      sleep(0.15)
      print self.first_char
      self.tail.fake_type
    else 
      puts 
    end 
  end
  
  def paragraphs
    # An alias for lines as paragraphs is more appropiate in this context 
    self.lines 
  end

  def is_header?
    # Header strings should be marked such as "# Whatever the ever"
    self.first_char == "#"
  end

  def is_error?
    # Error (from player input) strings to should be marked such as "# Whatever the ever"
    self.first_char == "!"
  end

  def bold 
   "\e[1m#{self}\e[22m" 
  end

  def underline
    # underlines a whole string
    "\e[4m#{self}\e[24m"
  end

  def underline_keywords
    # underlines a substring marked with <> e.g. -> <underline me>
    self.gsub("<", "\e[4m").gsub(">", "\e[0m")
  end

  def remove_punctuation
    # removes punctuation marks, useful for player input
    self.delete(".,;:´¨{}[]!\"\#$¢%&/()=?¿'¡*`<>")
  end
    
  def format_as_header
    # see is_header function above
    text = self[2..-1]
    text[0] = text[0].capitalize
    "\n #{text.bold.underline}\n" 
  end  

  def format_as_error
    # see is_error function above
    "\e[31m#{self[2..-1].underline}\e[0m" 
  end
 
  def tell(line_by_line=false)
    # prints a large string on the command line in a standarized format
    # i.e. what I think it's readable.
    unless self == ""
      sleep(0.1)
      puts 
      x = self
      x = x.format_as_error if x.is_error?
      x.paragraphs.each {
        |paragraph| 
        paragraph.get_lines.each {
          |line|
          line = line.format_as_header if line.is_header? 
          print line.underline_keywords 
          sleep(0.03)
          
        }
        gets if line_by_line
        puts
      }
    end
  end

  def insert_indeterminate_article 
    if ["a","e","i","o","u"].include?(self.first_char)
      "an <#{self}>"
    else 
      "a <#{self}>"
    end
  end

  def ask_yes_no
    self.tell 
    raw_answer = read_player_input
    case raw_answer.head.downcase
    when "yes", "y"
      true
    when "no", "n"
      false
    else
      "Sorry, expecting either a yes or a no".tell
      ask_yes_no
    end
  end  
  
  def get_lines(line_width=65, output=[])
    if self.size <= line_width then 
      output.push(self) 
    elsif self[line_width-1] == " "
      self[line_width..-1].get_lines(65, output.push(self[0..line_width-2] +"\n"))
    else 
      self.get_lines(line_width+1, output)
    end  
    output 
  end   

end