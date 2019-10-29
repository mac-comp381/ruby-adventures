# Programming Languages: Ruby Exercises

This assignment asks you to do several programming tasks designed to give you a feel for the Ruby language.

As you work through these tasks, consider: How would you implement this same task in Java? In Python? How does your development experience differ from those other languages? Get beyond the immediate shock of seeing unfamiliar syntax. Where do you find your attention going as you code in this language vs. the others? Why? What language features shape these differences?

(You **do not need to write up answers** to these questions. I am, however, curious to hear your thoughts!)


## Part 0: Getting oriented and set up

This project depends on several third-party libraries, which Ruby calls “[gems](https://rubygems.org).” Like most Ruby projects, this project uses [Bundler](http://bundler.io) to manage its gem dependencies and their versions. Together, Gems and Bundler are a “package manager.” (You may be familiar with other package managers: pip in Python and npm in Javascript. Both of those are based on RubyGems and Bundler.)

Take a look at `Gemfile`. It specifies which gems this project depends on, where to install them from, and optionally constraints on which version of the gem to use. (Note that `Gemfile` is itself Ruby code!)

Now take a look at `Gemfile.lock`. It specifies which gems bundler actually installed (including indirect dependencies not listed in the gemfile), where bundler got the gems from, and which exact version it installed. Checking this file into git helps ensure that an entire development team is using the same version of all the dependencies, and we don’t get into the situation where the code works for some people but not others.

To install the gems listed in `Gemfile`:

```bash
gem install bundler  # in case you don’t already have it
bundle install       # or you can just type `bundle`
```

Now test your installation:

```bash
bundle exec rake test
```

(The `bundle exec` prefix ensures that Ruby is using the exact version of each gem specified in `Gemfile.lock`. `rake` is a utility for running tasks from the command line. Common uses include running tests, setting up databases, creating test data, etc.)

The tests should run with some skips, but no failures or errors. Look for this at the end of the test output:

```bash
... 0 failures, 0 errors ...
```

If you see that, you’re up and running. (Don’t worry about the “shadowing outer local variables” warnings.)


## Part 1: Desugaring

Remember from class that “syntactic sugar” refers to features of a language’s syntax that make code easier to read and write, but do not provide any additional functionality. Ruby uses a lot of syntactic sugar.

Look at `lib/desugaring.rb`. The first method, `all_the_sugar`, contains a tiny snippet of somewhat realistic code from an imaginary web invitation system. (Actual email generation in Rails looks very similar to this.)

That snippet of code uses many kinds of syntactic sugar. **Your task is to remove the sugar,** one step at a time. For each method below, remove `implement_me` and replace it with the contents of the previous method in the file minus the particular kind of sugar the comment describes.

Please note that **the desugaring is cumulative**. You should copy the answer for each step forward to the next step, in the order the steps appear in the file. By the end, you should end up with a very different-looking implementation!

You can test that all your desugared versions work correctly by running the project tests, `bundle exec rake test`. I strongly recommend that you **run the tests after each step of the desugaring** before copying your code forward to the next step.


## Part 2: Going Loopless

The methods in `GoingLoopless` all work with data about people working on movies. They are all correct, but they all take a very Java-like, loop-based approach to their jobs.

Convert each of the four methods in `GoingLoopless` to use Ruby’s functional-stye list processing instead of loops.

When you are done:

- There should be no more calls to `each`.
- Each method should consist of a single statement.
- Each method should have less code than it started with.

The following Ruby methods may help you:

- `map`
- `select`
- `include?`
- `sort_by`
- `group_by`
- `uniq`
- `with_index`

Ask me for hints! And remember to run the tests early and often.


## Part 3: Metametaprogramming

The code in `lib/door.rb` specifies a door with three independent state machines: one for whether it is open or closed, and one each for the deadbolt and the knob lock.

The two locks affect the door state slightly differently: you can close a door if the knob is locked, but not the deadbolt. However, the two locks themselves have completely isomorphic state machine structures.

**Your task** is to use metaprogramming to generate the two lock state machines from a single template, so that the states and events of a lock only appear once in the code. This means that:

- you will use metaprogramming to generate two separate `aasm` definitions with the same structure
- which will then use metaprogramming to generate that actual state machines and all their methods
- which other code will then see as if you’d written out all the lock state machine code by hand.

In short, you are metaprogramming metaprogramming. Welcome to Rubyland. This is tricky to figure out, but takes only a _tiny_ bit of code when completed. Ask me for hints!
