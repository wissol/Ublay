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

  def find_thing_from_player_input(input_string, search_type=":all")
    # look also on players inventory
      candidates = compare_phrases_with_words(whats_here(search_type), input_string.remove_small_words)    
      case candidates[:found].size
      when 0
        nil # implement partial result
      when 1
        candidates[:found].head 
      else candidates[:found] 
        candidates[:found].make_list(conjuction="or").tell
        "Please type one or the other".tell 
        find_thing_from_player_input(read_player_input)
      end 

  end 

  def close predicate
    my_thing_string = find_thing_from_player_input(predicate)
    unless my_thing_string == nil 
      @things[my_thing_string].close_me
    else 
      "Sorry, I couldn't find that around here".tell
    end  
  end

  def drink
    place_holder_verb_function("drink")
  end

  def drop predicate
    thing_id = find_thing_from_player_input(predicate.remove_small_words, search_type=:inventory)
    unless thing_id == nil 
      @pc.remove_from_inventory(thing_id)
      @actual_room.add_thing_here(thing_id)
      "#{thing_id.capitalize} dropped.".tell 
    else 
      "! Sorry couldn't find that in your inventory.".tell
    end
  end

  def eat 
    place_holder_verb_function("eat")
  end

  def give 
    place_holder_verb_function("give")
  end

  def help
    read_text("help").tell 
  end    

  def look(predicate)
    predicate = predicate.remove_small_words
    if ['self', 'myself', @pc.name.downcase].include?(predicate.head)
      @pc.tell
    elsif ['room'].include?(predicate.head) || predicate == []
      @actual_room.examine(@things)
    else
      my_thing_id = find_thing_from_player_input(predicate)
      unless my_thing_id == nil
        my_thing = @things[my_thing_id]
        my_thing.full_desc.tell
        unless my_thing.on == []
          "On this item you may find: #{my_thing.list_things_on_me}.".tell
        end
      else 
        "! I am not able to find that, sorry".tell
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
        @actual_room.enter(@things)
      else 
        door = @portals[direction.head]
        if door.locked 
          "Sorry, there is a locked door here. Do you have a key?".tell 
        else 
         @actual_room = @rooms[direction[1]]
         @turns += 1
         @actual_room.enter(@things)
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

  def open predicate
    unless predicate == []
      my_thing_string = find_thing_from_player_input(predicate)
      unless my_thing_string == nil 
        @things[my_thing_string].open_me
      else 
        "Sorry, I couldn't find that around here".tell
      end
    else 
      "What do yo want to open?".tell 
      open read_player_input
    end   
  end

  def pull predicate
    unless predicate == []
      place_holder_verb_function("pull")
    else 
      "What do yo want to pull?".tell 
      pull read_player_input
    end   
  end

  def push
    unless predicate == []
      place_holder_verb_function("push")
    else 
      "What do yo want to push?".tell 
      push read_player_input
    end   
  end

  def put
    # should be put something on something else
    unless predicate == []
      place_holder_verb_function("put")
    else 
      "What do yo want to put?".tell 
      put read_player_input
    end 
  end

  def quit
    @over = true
  end

  def read(predicate)
    unless predicate == []
      place_holder_verb_function("read")
      my_book_id = find_thing_from_player_input(predicate.remove_small_words)
      unless my_book_id == nil 
        unless @things[my_book_id].text == nil 
          read_text(@things[my_book_id].text).tell(line_by_line=true) 
        else 
          "There's nothing I can read on that, sorry".tell
        end
      else 
        "! I can't seem to be able to find that, sorry".tell
      end
    else 
      "What do yo want me to read?".tell 
      read read_player_input
    end 
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
    @pc.inventory.each {|object| @things[object.downcase].list}
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
    something = @things[something] if something.is_a_string # cheapo way to stop the program from falling if I screw it up sending a thing_id instead of the thing itself
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

  def unlock predicate 
    unless predicate == []
      place_holder_verb_function("unlock")
    else 
      "What do you want me to unlock?".tell
      unlock read_player_input
    end 
  end

  def verbs 
    "answer, ask, attack, buy, close, down, drink, drop, east, eat, examine, give, help, inventory, "\
    "load, look, lock, listen, meditate, north, open, quit, pull, push, put, restart, restore, "\
    "save, show, sit on, say, swim, take, tell, south, unlock, up, verbs, wait, wear, west".tell
  end

  def wait 
    @turns += 1 
  end

  def wear predicate
    unless predicate == []
      place_holder_verb_function("wear")
    else
      "What do you want me to wear?".tell
      wear read_player_input
    end
  end

  def taste(predicate)
    if "self myself".include?(predicate.head)
        "You taste a little salty, 87% goblins consider you quite yummy, though".tell
      else
        ["Taste verb not working yet, sorry","Only a small baby will try and taste that, eek!", "no, don't make me!", "really?", "are you in your right mind?"].sample.tell
    end
  end  

