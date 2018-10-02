class Array
  def head
    self[0]
  end

  def tail
    self[1..-1]
  end

  def remove_small_words 
    small_words = ["at", "the", "a", "an", "to"]
    self.reject{|word| small_words.include?(word.downcase)}
  end

  def has_profanity?
    bad_words = "anal, anus, arse, ass, assfucker, asshole, assshole, bastard, bitch, boong, cock, cockfucker, cocksuck, cocksucker, coon, coonnass, crap, cunt, cyberfuck, damn, darn, dick, douche, dummy, erect, erection, erotic, escort, fag, faggot, fuck, fucking, fuckass, fuckhole, goddamn, gook, hore, fucker, motherfuck, motherfucker, negro, nigger, orgasim, orgasm, penis, penisfucker, piss, porn, porno, pornography, pussy, retard, sadist, sex, sexy, shit, slut, suck, tits, viagra, whore, xxx".split(", ")
    (self & bad_words).size > 0 # & meaning intersection 
  end

  

  def make_list(conjuction="and",calls=0)
    if self.size > 1
      "#{self.head.insert_indeterminate_article}, #{self.tail.make_list(calls=1)}"
    elsif calls > 0
      "#{conjuction} #{self.head.insert_indeterminate_article}"
    else
      "#{self.head.insert_indeterminate_article}"
    end 
  end
end