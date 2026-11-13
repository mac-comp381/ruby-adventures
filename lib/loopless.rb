

# Worked alone (no partner).
#
# Sources:
# - Hints from the assignment page (Part 2: Going Loopless), including the
#   per-method hints for find_all_in_role, list_movies, and build_credits.
# - Official Ruby documentation:
#   select:   https://docs.ruby-lang.org/en/master/Array.html#method-i-select
#   map:      https://docs.ruby-lang.org/en/master/Array.html#method-i-map
#   include?: https://docs.ruby-lang.org/en/master/Array.html#method-i-include-3F
#   uniq:     https://docs.ruby-lang.org/en/master/Array.html#method-i-uniq
#   sort_by:  https://docs.ruby-lang.org/en/master/Enumerable.html#method-i-sort_by
#   flat_map: https://docs.ruby-lang.org/en/master/Enumerable.html#method-i-flat_map
#   &:name:   https://docs.ruby-lang.org/en/master/Symbol.html#method-i-to_proc


require 'movie_data_model'
require 'set'

module GoingLoopless
  # Returns all the people who have taken on the role with the given name.
  #
  def find_all_in_role(role_name, people)
    people.select { |person| person.roles.map(&:name).include?(role_name) }
  end

  # List the titles and years of all the movies in which the given person played a role, in
  # chronological order.
  #
  def list_movies(person)
    person.roles.map(&:movie).uniq.sort_by(&:year).map { |movie| "#{movie.title} (#{movie.year})" }
  end

  # Creates a list of credits entry of the form "Person Name (role)", with the roles appearing in
  # the order specified in role_order, and each person appearing multiple times if they took on
  # multiple roles in the film.
  #
  def build_credits(movie, role_order)
    role_order.flat_map do |role_name|
      movie.roles.select { |role| role.name == role_name }
      .map { |role| "#{role.person.name} (#{role.name})" }
    end
  end
end
