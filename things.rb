
class Thing 
  # Contains the "objects" of the game world: a key, 

  attr_reader :desc, :on, :in, :weight, :open
  def initialize(x, id) 
    # x being a hash 
    @id = id
    @desc = x["desc"]
    @container = x["container"] == nil ? false : x["container"] 
    @weight = x["weight"] == nil ? 1 : x["weight"]
    @in = x["in_me"] == nil ? [] : x["in_me"]
    @on =  x["on_me"]  == nil ? [] : x["on_me"]
    @open = x["open"] == nil ? false : x["open"]
    @locked = x["locked"] == nil ? false : x["locked"]
    @key = x["locked"] == nil ? nil : x["key"]
    if @locked && @key == nil 
      $LOG.debug("Locked item #{@desc} but no key assigned, check things.yml")
      raise "Locked item #{@desc} but no key assigned, check things.yml"
    end
    @text = x["text"]
  end 

  def openable?
    @container or @text != nil
  end

  def open_me 
    unless @container == false
      @open = true
      "#{@id.capitalize} open.".tell 
    else 
      ["Why would you like to open the <#{@id}>.", "I shot the Sheriff, but I can't open the <#{@id}>"].sample.tell
    end
  end 

  def close_me
    unless @container == false
      @open = false
      "#{@id.capitalize} closed.".tell 
    else 
      "Something that cannot be closed\nCan it be opened?\nI wonder.\n\nAnd it turns out that the <#{@id}> can neither be opened or closed".tell
    end
  end 
  
 

  def list
    " - #{@desc}".tell
  end

  def list_things_on_me 
    @on.make_list("and")
  end

  def tell
    @desc.tell
  end

  def full_desc 
    out_desc = @desc 
    if @container
      out_desc += " It is #{@open ? 'open' : 'closed'}."
    end 
    out_desc
  end

end
    