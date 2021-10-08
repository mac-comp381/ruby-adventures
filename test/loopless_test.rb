require_relative 'movie_test_data'

describe GoingLoopless do
  include GoingLoopless
  include MovieTestData

  it "finds everyone who took on a certain role" do
    assert_equal [maurine, iluminada, deane, shantay, maryellen, delora, kimberli, rosamond, johnnie],
      find_all_in_role("director", people)

    assert_equal [ilya, shantay, willette, maryellen, yvette, rosamond],
      find_all_in_role("key grip", people)

    assert_equal [],
      find_all_in_role("flergleglurmph", people)

    assert_equal [],
      find_all_in_role("writer", [])
  end

  it "lists a peron's movies" do
    assert_equal [
        "The Electric Tears from the Black Lagoon (1967)",
        "Day of the Nuclear Journals (1989)",
        "The Ninja from Asteroid 6083 (2006)",
        "The Flying Identity from Across the Ocean (2016)"
      ],
      list_movies(iluminada)

    assert_equal [
        "The Danger Hills That Came to Dinner (1945)",
        "I am Clash (1946)",
        "I Married a City (1967)",
        "The Ninja from Asteroid 6083 (2006)"
      ],
      list_movies(delora)
  end

  it "builds a movie's credits" do
    assert_credits_match [
        "Delora Brekke (director)",
        "Shantay Gerhold (writer)",
        "Johnnie Glover (actor)",
        "Willette Schowalter (key grip)",
        "Kimberli Quigley (producer)",
        "Ilya Harris (producer)",
        "Shantay Gerhold (producer)"
      ],
      build_credits(married_a_city, ["director", "writer", "actor", "key grip", "producer"])

    assert_credits_match [
        "Maurine Kuhic (writer)",
        "Iluminada Halvorson (writer)",
        "Deane Shanahan (director)"
      ],
      build_credits(electric_tears, ["key grip", "writer", "director"])
  end

  def assert_credits_match(expected, actual)
    assert_equal Set.new(expected), Set.new(actual)  # same credits, any order
    assert_equal just_roles(expected), just_roles(actual)  # same roles, any actors
  end

  def just_roles(credits)
    credits.map { |c| c.gsub(/^.*\(/, "(") }
  end
end
