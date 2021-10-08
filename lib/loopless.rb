require 'set'

module GoingLoopless
  def find_all_in_role(role_name, people)
    results = []
    people.each do |person|
      person.roles.each do |role|
        if role.name == role_name
          results << person
          break
        end
      end
    end
    results
  end

  def build_credits(movie, role_order)
    results = []
    role_order.each do |role_name|
      movie.roles.each do |role|
        if role.name == role_name
          results << "#{role.person.name} (#{role.name})"
        end
      end
    end
    results
  end

  def list_movies(person)
    movies = []
    person.roles.each do |role|
      unless movies.include?(role.movie)
        movies << role.movie
      end
    end
    movies.sort_by!(&:year)  #  (&:year) is shorthand for { |o| o.year }

    results = []
    movies.each do |movie|
      results << "#{movie.title} (#{movie.year})"
    end
    results
  end
end

# ––– Data model –––

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
