
require_relative 'verbs.rb'
class Game
  attr_reader :rooms 
  include Verbs  
  
  def initialize   
    $LOG.info("----------------------------\nGame starts") 
    game_credits 
    @over = false
    @just_started = true
    @things = load_things
    $LOG.info("\n\nThings \n" + @things.inspect + "\n"  )
    @rooms = load_rooms 
    $LOG.info("\n\nrooms \n" + @rooms.inspect + "\n"  )
    @portals = load_portals
    $LOG.info("\n\nportals \n" + @portals.inspect + "\n"  )
    @first_room = @rooms["thomas_shed"]
    @pc = create_pc
    $LOG.info("\n\npc \n" + @pc.inspect  + "\n" )
    @turns = 0
  end    

  def load_things
    t = YAML.load_file('data/things.yml')
    output = {}
    t.each {|key,value| output[key] = Thing.new(value,key)}
    output
  end 

  def load_portals
    portals_dictionary = YAML.load_file('data/portals.yml')
    output = {}
    portals_dictionary.each {|key,value| output[key] = Portal.new(value)}
    output
  end 

  def load_rooms
    rooms_dictionary = YAML.load_file('data/rooms.yml')
    output = {}
    rooms_dictionary.each {|key,value| output[key] = Room.new(value)}
    output
  end   

  def whats_here
    @actual_room.is_here
  end 

  def parse(something)
   
   # something -> Array of strings (words), usually introduced by the player 
    verb = something.head
    predicate = something.tail
    $LOG.info("\n player input \n{#something}" )
    case verb
    when "answer"
      answer
    when "ask"
      ask
    when "buy"
      buy
    when "close"
      close predicate
    when "destroy", "attack", "hit"
      ["violence is not the solution", "all I am saying is give peace a chance", "a little thinking saves sweat, a little sweat saves blood", "The two most powerful warriors are patience and time. Leo Tolstoy said that, apparently"].sample.tell
    when "drink"
      drink
    when "drop"
      drop
    when "eat"
      eat  
    # --- examine synonym for look
    when "give"
      give
    when "h", "help"
      help  
    when "hear", "listen"
      listen   
    when "hold", "grab"
      hold(predicate.join(" "))
    when "i", "inventory"
      show_inventory
    when "l", "load", "restore"
      load    
    when  "x", "look", "examine"
      look(predicate)
    # movement --------------------------------------
    when "north", "n"
     go_to @actual_room.north
    when "south", "s"
     go_to @actual_room.south
    when "east", "e"
     go_to @actual_room.east
    when "west", "w"
     go_to @actual_room.west
    when "up", "u"
     go_to @actual_room.up
    when "down", "d"
     go_to @actual_room.down
    when "swim"
      swim
    when "go"
      possible_direction = predicate.remove_small_words.head
    
      if ["north","n","south","s","east","e","west","w","up","u","down","d"].include?(possible_direction)
        parse [possible_direction] # remember parse accepts arrays
      else 
        "! Sorry, I only understand going places like north, south, up, down and so forth".tell
      end
    # -------------------------------------------
    when "meditate"
      meditate
    when "open"
      open predicate
    when "pull"
      pull
    when "push"
      push
    when "put"
      put 
    when "q", "quit"
      quit
    when "restart"  
      restart  
    # restore synomym for load
    when "save"
      save
    when "show"
      show
    when "sit"
      sit
    when "say"
      say
    when "status"
      status
    when "take"
      something_key = predicate.remove_small_words.join(" ")
      something = @things[something_key]
      if @pc.inventory.include?(something_key)
        "! You have that got already. You might want to hold it, though".tell
      elsif something == nil
        "! Sorry, I don't seem to be able to find a #{something_key} here".tell
      elsif @actual_room.list_things.include?(something_key)
        take(something)
      else 
        "! Sorry, I don't seem to be able to find a #{something_key} here".tell
      end
    when "tell"
      tell
    when "taste"
      taste(predicate)
    when "verbs"
      verbs 
    when "wait"
      wait
    when "wear"
      wear
    else 
      me_no_understand      
    end  

  end 
  
  def over?
    @over
  end

  def game_credits
    "# Lost in Ublay".tell
    " An interactive fiction game v0.1".tell
  end  

  def show_intro(who)
    if who == "Thomas"
      "! Game Intro Not developed, sorry".tell
    else
      read_text("intro_not_thomas").tell 
      puts
      "> north\n".fake_type
    end
  end

  def create_pc # move this and show intro to game.new ???
    pc = Player.new
    is_Thomas = "\n Are you Thomas?".ask_yes_no
    unless is_Thomas
      "You are not Thomas, so who are you?".tell
      pc.create_random_character(read_player_input.join(" ").capitalize) 
    else
      "Thomas game play not yet developed, sorry\n Let's pretend you are not Thomas :D\nSo make up a name".tell 
      pc.create_random_character(read_player_input.join(" ").capitalize)  
    end
    pc
  end 
 
  def main
    if @just_started && ! over?      
      show_intro("not_thomas")
      @first_room.show(@things)
      @actual_room = @first_room
      @just_started = false 
    end
    
    unless over?
      parse(read_player_input)
      main
    else 
      "# game Over".tell
    end
  end
end
