# CHIP 4.6: WordGuesser on Rails - Answers

## 1. Run the App

**Q1.1. What is the goal of running `bundle install`?**
The goal of `bundle install` is to install all the dependencies (gems) required by the application, as specified in the `Gemfile` and `Gemfile.lock`. This ensures the environment has the correct versions of required libraries needed to run the app properly.

**Q1.2. Why is it good practice to specify `bundle config set without 'production'` when running it on your development computer?**
It prevents the installation of gems that are strictly needed for the production environment (such as the `pg` gem for a PostgreSQL production database or performance monitoring tools). Skipping these gems saves time, disk space, and avoids potential compilation errors on your development machine where production dependencies or their native extensions might not be available or required.

## 2. Where Things Are

**Q2.1. Where in the Rails app directory structure is the code corresponding to the WordGuesserGame model?**
The code for the model is located in `app/models/word_guesser_game.rb`.

**Q2.2. In what file is the code that most closely corresponds to the logic in the Sinatra apps' `app.rb` file that handles incoming user actions?**
The code handling incoming user actions is in `app/controllers/game_controller.rb`.

**Q2.3. What class contains that code?**
The `GameController` class.

**Q2.4. From what other class (which is part of the Rails framework) does that class inherit?**
It inherits from `ApplicationController` (which in turn inherits from `ActionController::Base` in the Rails framework).

**Q2.5. In what directory is the code corresponding to the Sinatra app's views (new.erb, show.erb, etc.)?**
The views are located in the `app/views/game/` directory.

**Q2.6. The filename suffixes for these views are different in Rails than they were in the Sinatra app. What information does the rightmost suffix of the filename (e.g.: in foobar.abc.xyz, the suffix .xyz) tell you about the file contents?**
The rightmost suffix (e.g., `.erb` in `show.html.erb`) specifies the templating engine or handler that Rails should use to parse and process the file. In this case, `.erb` means Embedded Ruby.

**Q2.7. What information does the other suffix tell you about what Rails is being asked to do with the file?**
The middle suffix (e.g., `.html` in `show.html.erb`) indicates the format or MIME type of the output that will be generated after the template is processed. In this case, it tells Rails to render the output as HTML.

**Q2.8. In what file is the information in the Rails app that maps routes (e.g. GET /new) to controller actions?**
The routes mapping information is located in `config/routes.rb`.

**Q2.9. What is the role of the `:as => 'name'` option in the route declarations of `config/routes.rb`? (Hint: look at the views.)**
The `:as => 'name'` option creates named route helpers (e.g., `new_game_path`, `guess_path`). These helper methods can be used in views and controllers to dynamically generate URL paths, so you don't have to hardcode explicit strings like `/new` or `/guess` throughout your code.

## 3. Session

**Q3.1. In the Sinatra version, `before do...end` and `after do...end` blocks are used for session management. What is the closest equivalent in this Rails app, and in what file do we find the code that does it?**
The closest equivalents in Rails are the `before_action` and `after_action` controller filters. Specifically, `before_action :get_game_from_session` and `after_action :store_game_in_session` are used. This code is found in `app/controllers/game_controller.rb`.

**Q3.2. A popular serialization format for exchanging data between Web apps is JSON. Why wouldn't it work to use JSON instead of YAML?**
If you serialize the `@game` object (an instance of `WordGuesserGame`) into JSON with `.to_json`, it simply becomes a JSON string representation of its attributes. When you parse it back out of the session with `JSON.parse()`, it returns a plain Ruby Hash. JSON does not natively retain Ruby class information. YAML, however, can serialize and deserialize custom Ruby objects natively, preserving the fact that the object is a `WordGuesserGame` instance with all its associated methods and internal state.

## 4. Views

**Q4.1. In the Sinatra version, each controller action ends with either `redirect` (which as you can see becomes `redirect_to` in Rails) to redirect the player to another action, or `erb` to render a view. Why are there no explicit calls corresponding to `erb` in the Rails version?**
Rails heavily relies on "Convention over Configuration". If an action doesn't explicitly redirect or render a specific view, Rails automatically looks for and renders the default view template that corresponds to the name of the controller and the action (e.g., it will automatically look for `app/views/game/show.html.erb` at the end of the `show` action).

**Q4.2. In the Sinatra version, we directly coded an HTML form using the `<form>` tag, whereas in the Rails version we are using a Rails method `form_tag`, even though it would be perfectly legal to use raw HTML `<form>` tags in Rails. Can you think of a reason Rails might introduce this "level of indirection"?**
Using `form_tag` (or `form_with`) automatically generates hidden security tokens (like the CSRF authenticity token) which protect the app from Cross-Site Request Forgery attacks. It also seamlessly integrates with Rails routing helpers to automatically figure out the correct submission URL and sets up proper form encoding.

**Q4.3. How are form elements such as text fields and buttons handled in Rails? (Again, raw HTML would be legal, but what's the motivation behind the way Rails does it?)**
Rails provides helpers (like `text_field_tag`, `submit_tag`, or model-bound form builders like `f.text_field`) that generate the HTML for you. The motivation is that these helpers automatically populate the input fields with existing data from your Ruby objects (making validation error handling much easier since they retain user input), provide standardized and concise syntax, and eliminate repetitive boilerplate HTML.

**Q4.4. In the Sinatra version, the `show`, `win` and `lose` views re-use the code in the `new` view that offers a button for starting a new game. What Rails mechanism allows those views to be re-used in the Rails version?**
Rails allows for re-using views or partials via the `render` method. In this app, the `show`, `win`, and `lose` views use `<%= render :template => 'game/new' %>` to embed the "new game" button from `new.html.erb` into themselves.

## 5. Cucumber scenarios

**Q5.1. What is a qualitative explanation for why the Cucumber scenarios and step definitions didn't need to be modified at all to work equally well with the Sinatra or Rails versions of the app?**
Cucumber acts like a user interacting with the application via a web browser (using Capybara). It tests the application from the *outside*. Since both the Sinatra and Rails versions expose the exact same user-facing behavior (the same URLs, the same HTML structures and forms, and the same business logic), the external behavior is identical. Cucumber does not care about the internal framework handling the requests; it only cares about the HTTP requests it makes and the HTML responses it receives.
