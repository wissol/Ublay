
class Room 
  
  attr_reader :north, :south, :east, :west, :up, :down, :is_here
  def initialize(dictionary)
    @short_desc = dictionary["short_desc"] == nil ? "" : dictionary["short_desc"]
    @long_desc = dictionary["long_desc"]
    @north = dictionary["north"]
    @south = dictionary["south"]
    @east = dictionary["east"]
    @west = dictionary["west"]
    @up = dictionary["up"]
    @down = dictionary["down"]
    @is_here = dictionary["is_here"]  == nil ? [] : dictionary["is_here"]
    @visited = dictionary["visited"] 
  end 

  def list_exits
    output = "Exits: "
    output += @north != nil ? "N" : " "
    output += @south != nil ? "S" : " "
    output += @east  != nil ? "E" : " " 
    output += @west  != nil ? "W" : " "
    output += @up    != nil ? "U" : " "
    output += @down  != nil ? "D" : " "
  end
 

  def full_desc
     "# #{@short_desc}\n#{@long_desc}\n"
  end

   def show(things)
    self.tell
    unless self.list_things == []
      things_here = "Items here: #{self.list_things.make_list("and")}."
      #self.list_things.each{|thing| things_here += "#{things[thing].desc}, "  }      
      things_here.tell 
    end 
    list_exits.tell
  end 
  
  def tell 
    @visited ?  @short_desc.tell : full_desc.tell 
    @visited = true
  end 

  def list_things
    @is_here
  end 

  def remove_item(item_key)
    @is_here.delete(item_key)
  end
  
end