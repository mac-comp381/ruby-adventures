require 'movie_data_model'
require 'set'

module GoingLoopless
  # Returns all the people who have taken on the role with the given name.
  #
  def find_all_in_role(role_name, people)
    people.select do |person|
      if person.roles.any? { |role| role.name == role_name }
        true
      end
    end
  end

  # List the titles and years of all the movies in which the given person played a role, in
  # chronological order.
  #
  def list_movies(person)
    person.roles.map(&:movie) # Get the movies they're in
          .uniq # Deduplicate
          .sort_by(&:year)
          .map { |movie| "#{movie.title} (#{movie.year})"} # Make it nice to read
  end

  # Creates a list of credits entry of the form "Person Name (role)", with the roles appearing in
  # the order specified in role_order, and each person appearing multiple times if they took on
  # multiple roles in the film.
  #
  def build_credits(movie, role_order)
    # This code works, but the people within each role have the wrong order (despite the roles being right)
    # movie.roles.sort_by { |role| role_order.find_index(role.name) }
    #      .map { |role| "#{role.person.name} (#{role.name})"} # This is giving the wrong sort within a role.

    role_order.flat_map do |role_name|
      movie.roles.select { |role| role.name == role_name }
    end.map { |role| "#{role.person.name} (#{role.name})" }
  end
end
