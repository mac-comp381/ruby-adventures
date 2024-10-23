require 'movie_data_model'
require 'set'

module GoingLoopless
  # Returns all the people who have taken on the role with the given name.
  #
  def find_all_in_role(role_name, people)
    results = people.filter do |person|
      person.roles.map do |role|
        role.name
      end
      .include? role_name
    end
    results
  end

  # List the titles and years of all the movies in which the given person played a role, in
  # chronological order.
  #
  def list_movies(person)
    movies = person.roles.map do |role|
      role.movie
    end
    .uniq

    movies.sort_by!(&:year)  #  (&:year) is shorthand for { |o| o.year }

    movies.map do |movie|
      "#{movie.title} (#{movie.year})"
    end
  end

  # Creates a list of credits entry of the form "Person Name (role)", with the roles appearing in
  # the order specified in role_order, and each person appearing multiple times if they took on
  # multiple roles in the film.
  #
  def build_credits(movie, role_order)
    role_order.map do |role_name|
      movie.roles.filter do |role|
        role.name == role_name
      end
      .map do |role| 
        "#{role.person.name} (#{role.name})"
      end
    end
    .flatten
  end
end
