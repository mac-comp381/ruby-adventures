require 'movie_data_model'
require 'set'

module GoingLoopless
  # Returns all the people who have taken on the role with the given name.
  #
  def find_all_in_role(role_name, people)
    people.select { |person| person.roles.any? { |role| role.name == role_name } }
  end

  # List the titles and years of all the movies in which the given person played a role, in
  # chronological order.
  #
  def list_movies(person)
    person.roles.map(&:movie).uniq.sort_by(&:year).map{ |movie| "#{movie.title} (#{movie.year})" }
  end

  # Creates a list of credits entry of the form "Person Name (role)", with the roles appearing in
  # the order specified in role_order, and each person appearing multiple times if they took on
  # multiple roles in the film.
  #
  def build_credits(movie, role_order)
    # role_order.map(&:movie).uniq.sort_by(&:year).map{ |movie| "#{movie.title} (#{movie.year})" }
    # role_order.select{ |role_name| role_name.any? { |role| role.name == role_name } }.map{ |role| "#{role.person.name} (#{role.name})" }
  #   results = []
  #   role_order.each do |role_name|
  #     movie.roles.each do |role|
  #       if role.name == role_name
  #         results << "#{role.person.name} (#{role.name})"
  #       end
  #     end
  #   end
  #   results
  # end
end
