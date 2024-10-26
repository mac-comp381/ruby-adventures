require 'movie_data_model'
require 'set'

module GoingLoopless
  # Returns all the people who have taken on the role with the given name.
  #
  def find_all_in_role(role_name, people)
    people.select{|person| person.roles.map(&:name).include? role_name}
  end

  # List the titles and years of all the movies in which the given person played a role, in
  # chronological order.
  #
  def list_movies(person)
    person.roles.sort_by{|role| role.movie.year}.map{|role| "#{role.movie.title} (#{role.movie.year})"}.uniq
  end

  # Creates a list of credits entry of the form "Person Name (role)", with the roles appearing in
  # the order specified in role_order, and each person appearing multiple times if they took on
  # multiple roles in the film.
  #
  def build_credits(movie, role_order)
    movie.roles.select{|role| role_order.include?(role.name)}.group_by{|role| role.name}.sort_by{|k, v| role_order.find_index(k)}.flat_map{|k,v| v}.map{|role| "#{role.person.name} (#{role.name})"} 
  end
end
