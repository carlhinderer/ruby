# Invoice Summary Reports

To run the application (in development mode):

```bash
# Run the migrations
$ rails db:migrate

# Seed the database with test data
$ rails db:seed

# Start the background processing queue
$ bin/delayed_job start

# Start the application
$ rails s
```

To run the tests:

```bash
# Run the migrations
$ RAILS_ENV=test rails db:migrate

# Run the tests
$ bundle exec rspec
```

Design Considerations:

* For the sake of simplicity, I stuck with SQLite as the database, so that the application doesn't need to live outside of it's own directory.

* Also for simplicity, I used _delayed_job_ for background processing, since it also doesn't require anything outside of the project's own directory.

* I used ActiveJob for background tasks and ActiveStorage for storing reports, since it felt like the Rails-y thing to do, and because I haven't used them before, and they were fun to learn.

* I decided to stick with _ruby 2.7_ and _rails 5_ since ruby 3 / rails 6 seemed a bit more bleeding-edge.


Things That Need Work:

* The reports need to be more extensible.  Right now, the _Report_ model is tightly coupled to the _InvoiceSummaryReport_.

* If I had more time, the first thing I would do is write Capybara features for integration tests.

* Also, I would figure out how to test _ActiveStorage_, so that the specs for the background processing job and helper that displays the file links could be implemented.

* Right now, I'm using the same form for both previewing and creating a report, which is arguably against conventions.  It would be good to rethink this.

* Reports should be managed in a more sophisticated way (ie reports that already exist shouldn't be re-created).