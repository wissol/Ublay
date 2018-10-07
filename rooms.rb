
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

  def full_desc(world_things)
     "# #{@short_desc}\n#{@long_desc}\n".tell
     list_my_contents(world_things)
  end

  def list_my_contents(world_things)
    unless self.list_things == []
      "Items here: #{self.list_things.make_list("and")}.".tell      
      is_here.each{|id| world_things[id].list_things_on_me.tell}
      is_here.each{|id| world_things[id].list_things_in_me.tell}
    end 
    list_exits.tell
  end

  def examine(world_things)
    self.full_desc(world_things)     
  end  

  def enter(world_things)
    show(world_things)
    mark_as_visited
  end 

  def show(world_things)
    # displays 
    @visited ?  @short_desc.tell : full_desc(world_things)
  end 

  def list_things
    @is_here
  end 

  def remove_item(item_key) # or remove_thing ??
    @is_here.delete(item_key)
  end

  def add_thing_here(thing_key)
    @is_here.push(thing_key)
  end

  def mark_as_visited
    @visited = true 
  end
  
end