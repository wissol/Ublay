class Portal
  attr_reader :locked
  def initialize(dictionary)
    @desc = dictionary["desc"]
    @locked = dictionary["locked"]
    @key = dictionary["key"]
    @weight = 10000  # so it can't be taken
  end 

  def tell
    to_add = @locked ? "It is locked." : "It is unlocked."
    "#{@desc} #{to_add}".tell
  end  
  
  def lock_unlock(held_key)
    if held_key == @key 
      @locked = not(@locked)
      @locked ? "It is locked now.".tell : "It is unlocked now.".tell
    elsif held_key == nil 
      ["Hey, you need a key for that!", "What do you use to operate a door... Let me think!"].sample.tell
    else 
      "Sorry, that's not the right key for this door".tell
    end
  end


end