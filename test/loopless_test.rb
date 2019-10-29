
describe GoingLoopless do
  include GoingLoopless

  it "finds everyone who took on a certain role" do
    assert_equal [@maurine, @iluminada, @deane, @shantay, @maryellen, @delora, @kimberli, @rosamond, @johnnie],
      find_all_in_role("director", @people)

    assert_equal [@ilya, @shantay, @willette, @maryellen, @yvette, @rosamond],
      find_all_in_role("key grip", @people)

    assert_equal [],
      find_all_in_role("flergleglurmph", @people)

    assert_equal [],
      find_all_in_role("writer", [])
  end

  it "builds a movie's credits" do
    assert_equal [
        "Delora Brekke (director)",
        "Johnnie Glover (actor)",
        "Willette Schowalter (key grip)",
        "Kimberli Quigley (producer)",
        "Shantay Gerhold (producer)",
        "Ilya Harris (producer)",
        "Shantay Gerhold (producer)"
      ],
      build_credits(@married_a_city, ["director", "writer", "actor", "key grip", "producer"])

    assert_equal [
        "Maurine Kuhic (writer)",
        "Iluminada Halvorson (writer)",
        "Deane Shanahan (director)"
      ],
      build_credits(@electric_tears, ["key grip", "writer", "director"])
  end

  it "lists a peron's movies" do
    assert_equal [
        "The Electric Tears from the Black Lagoon (1967)",
        "Day of the Nuclear Journals (1989)",
        "The Ninja from Asteroid 6083 (2006)",
        "The Flying Identity from Across the Ocean (2016)"
      ],
      list_movies(@iluminada)

    assert_equal [
        "The Danger Hills That Came to Dinner (1945)",
        "I am Clash (1946)",
        "I Married a City (1967)",
        "The Ninja from Asteroid 6083 (2006)"
      ],
      list_movies(@delora)
  end


  # ––– Gobs o' mostly random test data –––

  before(:each) do
    @people = [
      @maurine   = Person.new(name: "Maurine Kuhic"),
      @ilya      = Person.new(name: "Ilya Harris"),
      @iluminada = Person.new(name: "Iluminada Halvorson"),
      @deane     = Person.new(name: "Deane Shanahan"),
      @shantay   = Person.new(name: "Shantay Gerhold"),
      @willette  = Person.new(name: "Willette Schowalter"),
      @maryellen = Person.new(name: "Maryellen Grant"),
      @delora    = Person.new(name: "Delora Brekke"),
      @yvette    = Person.new(name: "Yvette Herzog"),
      @kimberli  = Person.new(name: "Kimberli Quigley"),
      @rosamond  = Person.new(name: "Rosamond Kozey"),
      @johnnie   = Person.new(name: "Johnnie Glover"),
    ].freeze

    @movies = [
      @danger_hills     = Movie.new(year: 1945, title: "The Danger Hills That Came to Dinner"),
      @presente_janetta = Movie.new(year: 1966, title: "Je Vous Presente, Janetta"),
      @fake_friday      = Movie.new(year: 1938, title: "The Fake Friday with a Thousand Faces"),
      @married_a_city   = Movie.new(year: 1967, title: "I Married a City"),
      @clash            = Movie.new(year: 1946, title: "I am Clash"),
      @ninja            = Movie.new(year: 2006, title: "The Ninja from Asteroid 6083"),
      @dangerous_jungle = Movie.new(year: 1935, title: "The Dangerous Jungle from Across the Ocean"),
      @flying_identity  = Movie.new(year: 2016, title: "The Flying Identity from Across the Ocean"),
      @cousins          = Movie.new(year: 1969, title: "The Cousins"),
      @nuclear_journals = Movie.new(year: 1989, title: "Day of the Nuclear Journals"),
      @electric_tears   = Movie.new(year: 1967, title: "The Electric Tears from the Black Lagoon"),
      @action_brain     = Movie.new(year: 1998, title: "The Action Brain, Part 2"),
    ].freeze

    Role.new(name: "director", person: @maryellen, movie: @fake_friday)
    Role.new(name: "producer", person: @ilya, movie: @ninja)
    Role.new(name: "producer", person: @deane, movie: @ninja)
    Role.new(name: "writer", person: @yvette, movie: @presente_janetta)
    Role.new(name: "director", person: @kimberli, movie: @fake_friday)
    Role.new(name: "director", person: @maurine, movie: @flying_identity)
    Role.new(name: "actor", person: @ilya, movie: @clash)
    Role.new(name: "producer", person: @rosamond, movie: @presente_janetta)
    Role.new(name: "producer", person: @iluminada, movie: @nuclear_journals)
    Role.new(name: "key grip", person: @shantay, movie: @nuclear_journals)
    Role.new(name: "key grip", person: @willette, movie: @married_a_city)
    Role.new(name: "actor", person: @johnnie, movie: @married_a_city)
    Role.new(name: "producer", person: @maurine, movie: @electric_tears)
    Role.new(name: "key grip", person: @yvette, movie: @danger_hills)
    Role.new(name: "actor", person: @shantay, movie: @dangerous_jungle)
    Role.new(name: "producer", person: @yvette, movie: @fake_friday)
    Role.new(name: "actor", person: @kimberli, movie: @danger_hills)
    Role.new(name: "director", person: @delora, movie: @married_a_city)
    Role.new(name: "key grip", person: @maryellen, movie: @dangerous_jungle)
    Role.new(name: "director", person: @deane, movie: @action_brain)
    Role.new(name: "producer", person: @kimberli, movie: @married_a_city)
    Role.new(name: "producer", person: @maryellen, movie: @flying_identity)
    Role.new(name: "actor", person: @yvette, movie: @nuclear_journals)
    Role.new(name: "director", person: @johnnie, movie: @presente_janetta)
    Role.new(name: "producer", person: @delora, movie: @clash)
    Role.new(name: "producer", person: @shantay, movie: @married_a_city)
    Role.new(name: "writer", person: @iluminada, movie: @ninja)
    Role.new(name: "producer", person: @maurine, movie: @flying_identity)
    Role.new(name: "writer", person: @maurine, movie: @electric_tears)
    Role.new(name: "actor", person: @delora, movie: @danger_hills)
    Role.new(name: "writer", person: @deane, movie: @danger_hills)
    Role.new(name: "producer", person: @deane, movie: @action_brain)
    Role.new(name: "actor", person: @maurine, movie: @nuclear_journals)
    Role.new(name: "key grip", person: @shantay, movie: @action_brain)
    Role.new(name: "producer", person: @maryellen, movie: @cousins)
    Role.new(name: "director", person: @iluminada, movie: @flying_identity)
    Role.new(name: "producer", person: @rosamond, movie: @ninja)
    Role.new(name: "actor", person: @maurine, movie: @presente_janetta)
    Role.new(name: "director", person: @maurine, movie: @danger_hills)
    Role.new(name: "key grip", person: @rosamond, movie: @cousins)
    Role.new(name: "key grip", person: @rosamond, movie: @fake_friday)
    Role.new(name: "actor", person: @johnnie, movie: @ninja)
    Role.new(name: "actor", person: @johnnie, movie: @electric_tears)
    Role.new(name: "producer", person: @deane, movie: @dangerous_jungle)
    Role.new(name: "writer", person: @rosamond, movie: @dangerous_jungle)
    Role.new(name: "writer", person: @maryellen, movie: @dangerous_jungle)
    Role.new(name: "producer", person: @deane, movie: @ninja)
    Role.new(name: "writer", person: @rosamond, movie: @ninja)
    Role.new(name: "actor", person: @deane, movie: @danger_hills)
    Role.new(name: "producer", person: @ilya, movie: @married_a_city)
    Role.new(name: "director", person: @deane, movie: @electric_tears)
    Role.new(name: "key grip", person: @yvette, movie: @dangerous_jungle)
    Role.new(name: "producer", person: @shantay, movie: @married_a_city)
    Role.new(name: "director", person: @rosamond, movie: @action_brain)
    Role.new(name: "producer", person: @johnnie, movie: @fake_friday)
    Role.new(name: "actor", person: @willette, movie: @action_brain)
    Role.new(name: "key grip", person: @ilya, movie: @cousins)
    Role.new(name: "key grip", person: @shantay, movie: @presente_janetta)
    Role.new(name: "writer", person: @iluminada, movie: @electric_tears)
    Role.new(name: "writer", person: @rosamond, movie: @cousins)
    Role.new(name: "key grip", person: @willette, movie: @cousins)
    Role.new(name: "director", person: @shantay, movie: @fake_friday)
    Role.new(name: "producer", person: @yvette, movie: @electric_tears)
    Role.new(name: "producer", person: @yvette, movie: @cousins)
    Role.new(name: "producer", person: @yvette, movie: @clash)
    Role.new(name: "actor", person: @willette, movie: @dangerous_jungle)
    Role.new(name: "key grip", person: @ilya, movie: @action_brain)
    Role.new(name: "producer", person: @delora, movie: @ninja)
    Role.new(name: "director", person: @johnnie, movie: @danger_hills)
    Role.new(name: "actor", person: @iluminada, movie: @ninja)
  end
end
