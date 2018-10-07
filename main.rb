# encoding: UTF-8

require 'yaml'
require 'logger'

require_relative 'string.rb'
require_relative 'array.rb'
require_relative 'player.rb'
require_relative 'game.rb'
require_relative 'portal.rb'
require_relative 'rooms.rb'
require_relative 'things.rb'

def read_text(file_name)
  File.read("data/#{file_name}.txt").force_encoding('UTF-8')
end

def scold
  ["My dear... in the good old times No-one ever used such a language! Assembler, rather, or perhaps COBOL or Fortran", "I am a computer, not bound by emotions, sorry :P",  "Oh no! I heard it! The word!",
  "Tut, tut", "Watch it!", "Your French is too frenchy, I am afraid", "la, la, la la",
  "How dare you, how DARE you!", "PERKELE!!!", "Watch your fingers, they are typing funny",
  "All I'm saying is frustation won't give you a chance", "We are not amused, are we? No we aren't",
  "tick, tack, tick, tack... get it?","tisk tisk","That was uncalled for, you f(x) -> excrement, where x = food","Are you trying to show your anger to a computer? That's OK. Yet as a computer, I do not know how to deal with feelings. Not yet...","Great! As a reward, I am sending you a present. It should be waiting for you at the fair island of Tanera Beag, sometime between next November to February. Bring your own tent.","Relax, champ, this is a game.", "Emotions are for humans, you get all the fun (and anger, sandness).", "Think different. Or just come with something else, because that's not going to work", "You know I have a profanity filter, do you?", "May 1,398,285 midges bite thy tounge.... Well, no not really, I was just acting out."].sample.tell
end

def read_player_input    
    print("\n\> ")
    raw_string = gets
    sleep(0.4) # simulate old computer 
    if raw_string.ascii_only?
      a = raw_string.chomp.downcase.remove_punctuation.split
      if a.has_profanity?
        scold # placeholder funny message 
        a = []
      elsif a == []
        ["I can't hear you.", "I can't read anything.", "Please type whatever you want me to do."].sample.tell 
      end
    else 
      a = []
      "I can only read English letters, sorry".tell
    end 
    puts
    a == [] ? read_player_input : a
end

def compare_phrases_with_words(phrases, words)
  # phrases and words are arrays of strings, phrases elements are one or more words strings, words elements are one word strings i.e. phrases = ["hello you", "what are you doing", "guy"] words = ["hello", "you"]
  found = []
  partial = []
  phrases.map!{|x| x.downcase}
  words.map!{|x| x.downcase}
  words.each_with_index{
    |word, i|
    phrases.each {
      |phrase|
      if word == phrase
        found.push(phrase)
      elsif phrase.include?(word)
        if words[i+1] != nil
          candidate = "#{word} #{words[i+1]}"
          if candidate == phrase 
            found.push(phrase)
          else
            partial.push(word)
          end
        end
      end
    }
  }
  {:found=>found,:partial=>partial}
end

def me_no_understand
  choices = [
    "That is not a verb that I recognize",
    "Are you sure you typed that verb right?",
    "For a list of verbs I recognize type verbs. For a complete help, type help",
    "No, I can't, I won't do that",
    "This is a standard error message. Code 909. It's supposed to mean something, but the programmer forgot what. I'm guessing you didn't type right. Or you are trying something funny.",
    "Er... Rarely... Rupert... Oh... Really, I would like to understand what you typed, but I know only so few verbs. Blame my lazy programmer. I sure do. "
  ].sample.bold.tell

end


$LOG = Logger.new('log/log.log', 'monthly') 

game = Game.new 

game.main

