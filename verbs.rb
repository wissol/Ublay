module Verbs

  def place_holder_verb_function(x)
    "The verb \"#{x}\" has not been implemented yet, sorry".tell
  end

  def answer 
    place_holder_verb_function("answer")
  end
    
  def ask 
    place_holder_verb_function("ask")
  end

  def buy
    place_holder_verb_function("buy")
  end

  def close predicate
    place_holder_verb_function("close")  # ---- really unify this with open!!!
    predicate = predicate.remove_small_words  # ---- make this into a function 
    candidates = compare_phrases_with_words(whats_here, predicate)
    if candidates[:found].size == 1
        my_thing = @things[candidates[:found].head]
        my_thing.close_me
         # make this into a function
      end
  end

  def quit
    @over = true
  end

  def drink
    place_holder_verb_function("drink")
  end

  def drop 
    place_holder_verb_function("drop")
  end

  def eat 
    place_holder_verb_function("eat")
  end

  def give 
    place_holder_verb_function("give")
  end

  def hold(something)    
    if @pc.inventory.include?(something)
      dropped = @pc.grasp(something)
      "Done. I needed to drop #{@things[dropped]}".tell unless dropped == nil  
    else
      succesful_carry = take(something)  
      hold(something) if succesful_carry
    end
  end

  def help
    read_text("help").tell 
  end    

  def look(predicate)
    predicate = predicate.remove_small_words
    if ['self', 'myself', @pc.name.downcase].include?(predicate.head)
      @pc.tell
    elsif ['room'].include?(predicate.head) || predicate == []
      @actual_room.show(@things)
    else
      candidates = compare_phrases_with_words(whats_here, predicate)
      if candidates[:found].size == 1
        my_thing = @things[candidates[:found].head]
        my_thing.full_desc.tell
        unless my_thing.on == []
          "On this item you may find: #{my_thing.list_things_on_me}.".tell
        end
      end
    end
    end
  end  

  def go_to(direction)
    case direction
    when "wall"
      "One day you might be able to get through walls; but not today".tell
    when nil 
      "You can't go in that direction".tell   
    else
      if direction.head == nil 
        @actual_room = @rooms[direction[1]] # direction[0] contains either nil or a door (aka portal)
        @turns += 1 
        @actual_room.show(@things)
      else 
        door = @portals[direction.head]
        if door.locked 
          "Sorry, there is a locked door here. Do you have a key?".tell 
        else 
         @actual_room = @rooms[direction[1]]
         @actual_room.tell
        end
      end
    end 
  end  

  def listen 
    place_holder_verb_function("listen")
  end

  def load 
    place_holder_verb_function("load")
  end

  def extract_direct_object(predicate)
    predicate = predicate.remove_small_words  # ---- make this into a function 
    candidates = compare_phrases_with_words(whats_here, predicate)
    if candidates[:found].size == 1
        @things[candidates[:found].head]
    elsif candidates[:found].size > 1
        "Did you mean "
    end 
  end

  def open predicate
    place_holder_verb_function("open")
    
        my_thing = @things[candidates[:found].head]
        my_thing.open_me
         # make this into a function

  end

  def pull
    place_holder_verb_function("pull")
  end

  def push
    place_holder_verb_function("push")
  end

  def put
    place_holder_verb_function("put")
  end

  def read 
     place_holder_verb_function("read")
  end

  def restart 
    place_holder_verb_function("restart")
  end

  def save
    place_holder_verb_function("save")
  end  

  def say
    place_holder_verb_function("say")
  end

  def show_inventory
    "# Your things".tell
    @pc.inventory.each {|object| @things[object].list}
  end 

  def swim
    place_holder_verb_function("swim")
  end

  def sit
    place_holder_verb_function("sit on")
  end  

  def status
    "Turn: #{@turns} Health: #{@health} Date: 00:00".tell
  end 

  def take(something)
    if something.weight >= @pc.max_carry
      "! Sorry, that's too heavy for you to carry"
    elsif @pc.total_carried(@things) + something.weight > @pc.max_carry 
      "! Sorry, you can't have that and everything else. Drop something from your inventory first!".tell
    else 
      "Taken: #{something.desc}".tell
      @actual_room.remove_item(@things.key(something))
      @pc.add_to_inventory(@things.key(something))  
    end
  end

  def tell_somebody
    place_holder_verb_function("tell")
  end

  def verbs 
    "answer, ask, attack, buy, close, down, drink, drop, east, eat, examine, give, help, inventory, "\
    "load, look, listen, meditate, north, open, quit, pull, push, put, restart, restore, "\
    "save, show, sit on, say, swim, take, tell, south, up, verbs, wait, wear, west".tell
  end

  def wait 
    @turns += 1 
  end

  def wear 
    place_holder_verb_function("wear")
  end

  def taste(predicate)
    if "self myself".include?(predicate.head)
        "You taste a little salty, 87% goblins consider you quite yummy, though".tell
      else
        ["Taste verb not working yet, sorry","Only a small baby will try and taste that, eek!", "no, don't make me!", "really?", "are you in your right mind?"].sample.tell
    end
  end  

