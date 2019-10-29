# Convert each of the four methods in GoingLoopless to use Ruby’s
# functional-stye list processing instead of loops.
#
# When you are done, there should be no calls to .each, and each
# method should consist of a single statement.
#
# The following Ruby methods may help you:
#
#     map
#     select
#     include?
#     sort_by
#     group_by
#     uniq
#     with_index
#
# Ask me for hints! And remember to run the tests early and often.

module GoingLoopless
  def find_all_in_role(role_name, people)
    people.select { |p| p.roles.map(&:name).include?(role_name) }
  end

  def build_credits(movie, role_order)
    movie.roles
      .sort_by { |role| role_order.find_index(role.name) || role_order.length }
      .map { |role, index| "#{role.person.name} (#{role.name})" }
  end

  def list_movies(person)
    person.roles
      .map(&:movie)
      .uniq
      .sort_by(&:year)
      .map.with_index { |movie| "#{movie.title} (#{movie.year})" }
  end

  def summarize_roles(person)
    person.roles
      .group_by { |role| role.name}
      .map { |role_name, roles| [role_name, roles.size] }
      .sort_by { |role_name, count| [-count, role_name] }
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
