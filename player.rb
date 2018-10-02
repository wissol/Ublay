class Player
  attr_reader :name, :inventory
  def initialize
    @name = "Thomas"
    @age = 14
    @health = 100
    @inventory = ["ACME key"]
    @in_hands = nil
    @has_backpack = true
  end

  def total_carried(things_hash)
    x = 0
    @inventory.each {|item| x += things_hash[item].weight}
    x
  end

  def max_carry
    x = @has_backpack ? 30 : 6
  end

  def empty_handed?
    @in_hands == nil 
  end

  def grasp(something)    
    dropped_item = empty_handed? ? nil : @in_hands
    @in_hands = something   
    puts "holding" + @in_hands.inspect  
    dropped_item
  end

  def add_to_inventory(something_key)
    @inventory.push(something_key)
  end



  def inc_health(x)
    @health = (@health + x) > 100 ? 100 : @health + x
  end

  def suffer_injury(x)
    @health -= x
  end


  def is_dead?
    @health < 0
  end 

  def desc
    "you are a #{@age} years old kid, who is #{health_to_s}"
  end

  def health_to_s
    case @health 
    when 100 then "in perfect shape"
    when 80..99 then "quite fit for an adventure"
    when 70..79 then "fine, but for a little pain"
    when 50..69 then "needing some rest, well reserved or not"
    when 40..49 then "not so well"
    when 20..39 then "pretty unhealthy, to be honest"
    when 1..19 then "worn, injured and pretty bloodied"
    else "quite dead"
    end
  end

  def tell 
    "#{@name}, #{desc}".tell
  end  

  def create_random_character(name)
    @name = name 
    @age = [12,13,14,15].sample
  end
    
end