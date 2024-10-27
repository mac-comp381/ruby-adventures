require 'movie_data_model'
require 'set'

module GoingLoopless
  # Returns all the people who have taken on the role with the given name.
  #
  # def find_all_in_role(role_name, people)
  #   results = []
  #   people.each do |person| # for each person in the people list
  #     person.roles.each do |role| # Get each role
  #       if role.name == role_name # if the role name matches the input
  #         results << person # add it to the list
  #         break # and break
  #       end
  #     end
  #   end
  #   results
  # end

  def find_all_in_role(role_name, people)
    people.select {
      |person| person.roles.map(&:name).include?(role_name) # on each person in people map if their role matches the input role
    }
  end

  # List the titles and years of all the movies in which the given person played a role, in
  # chronological order.

  def list_movies(person)
    # movies = []
    # person.roles.each do |role|
    #   unless movies.include?(role.movie)
    #     movies << role.movie # add the movie unless it is already in there
    #   end
    # end
    # movies.sort_by!(&:year)  #  (&:year) is shorthand for { |o| o.year }, sort by yeaer

    # results = []
    # movies.each do |movie| 
    #   results << "#{movie.title} (#{movie.year})" # for each movie in movies add that to results and format it
    # end
    # results

    person.roles.map(&:movie).uniq().sort_by(&:year).map { # grab unqiue movies the person played a role in, sort it by year
      |movie| "#{movie.title} (#{movie.year})" # for each movie evaluate the title and year
    }
  end

  # Creates a list of credits entry of the form "Person Name (role)", with the roles appearing in
  # the order specified in role_order, and each person appearing multiple times if they took on
  # multiple roles in the film.
  #
  def build_credits(movie, role_order)
    results = []
    role_order.each do |role_name| # for each role in the specified role order input list
      movie.roles.each do |role| # evaluate on each movie role
        if role.name == role_name # if the role name matches the input role name
          results << "#{role.person.name} (#{role.name})" # add the person and the role name to a list
        end
      end
    end
    results
  end

  role_order.flat_map do |role_name| # for each role in the role order map
    movie.roles.select { # select each from the movie's roles
      |role| role.name == role_name # but only if the role name is equal to the current evaluation
    }.map { # then map...
      |role| "#{role.person.name} (#{role.name})" # each role to the actor's name and the role's name.
    }
  end
end
