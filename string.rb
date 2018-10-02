
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
      sleep(0.3)
      print self.first_char
      self.tail.fake_type
    else 
      puts 
    end 
  end
  
  def paragraphs
    # I'm creating an alias for lines as paragraphs is more appropiate in this context 
    self.lines 
  end

  def is_header?
    self.first_char == "#"
  end

  def is_error?
    self.first_char == "!"
  end

  def bold 
   "\e[1m#{self}\e[22m" 
  end

  def underline
      "\e[4m#{self}\e[24m"
  end

  def remove_punctuation
    self.delete(".,;:´¨{}[]!\"\#$¢%&/()=?¿'¿¡*`<>")
  end
    
  def format_as_header
    text = self[2..-1]
    text[0] = text[0].capitalize
    "\n #{text.bold.underline}\n" 
  end  

  def format_as_error
    "\e[31m#{self[2..-1].underline}\e[0m" 
  end

  def blue
    "\e[#{35}m#{self}\e[0m"
  end

  def tell
  
    puts 
     x = self
     x = x.format_as_error if x.is_error?
     x.paragraphs.each {
      |paragraph| 
      paragraph.get_lines.each {
        |line|
        line = line.format_as_header if line.is_header? 
        line = line.gsub("<", "\e[44m\e[4m") # 44 -> background blue, 4m underline 
        line = line.gsub(">", "\e[24m\e[0m") # closes background and underline codes
        print line
      }
      puts
    }
  end

  def insert_indeterminate_article 
    if ["a","e","i","o","u"].include?(self.first_char)
      "an #{self}"
    else 
      "a #{self}"
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