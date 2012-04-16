class Media
end

class Movie < Media

  def initialize(title, year)
    @title = title
    @year = year
  end
  
end

class TVShow < Media

  attr_accessor :title, :season, :episode
  
  def initialize(title, season, episode)
    @title = title
    @season = season
    @episode = episode
  end

end
