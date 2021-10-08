class Person
  attr_reader :name, :roles

  def initialize(name:)
    @name = name
    @roles = []
  end

  def inspect
    "Person(@name=#{name.inspect})"
  end
end

class Role
  attr_reader :name, :person, :movie

  def initialize(name:, person:, movie:)
    @name, @person, @movie = name, person, movie
    @person.roles << self
    @movie.roles << self
  end

  def inspect
    "Role(@name=#{name.inspect}, @person=#{person.name.inspect}, @movie=#{movie.title.inspect})"
  end
end

class Movie
  attr_reader :title, :year, :roles

  def initialize(title:, year:)
    @title, @year = title, year
    @roles = []
  end

  def inspect
    "Movie(@title=#{title.inspect}, @year=#{year.inspect})"
  end
end
