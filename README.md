
# Brewery Application

## What It Does
The brewery application creates a menu of available beers based on a set of customer preferences, and displays details about those beers to the user.

## How Does It Work?
The application loads a data file, which indicates:
 - The number of beers to brew
 - The preferences of each customer, showing which beers they prefer and in which style (classic or barrel aged)

From that a menu with beers from 1->n is produced. Because we want to minimise the number of barrel aged beers we need to create in order to satisfy everyone, we start with a menu that is entirely classic. We then loop through all the possible menus with increasing numbers of barrel aged beers to until we find a menu that satisfies all the customers. Because we're checking in this order, we can be confident that we're only producing as many barrel aged beers as is required. If we exhaust all options and still haven't found a satisfactory menu, we know a solution isn't possible.

## Architecture
The application is build with CleanSwift design pattern. https://clean-swift.com/. Each ViewController follows a View -> Interactor -> Presenter -> View cycle to display new data.

## Tests
Currently, tests are available for all the components responsible for creating a menu based on customer preferences.

## Improvements
Given the time, there are a number of improvements I would consider, in rough order of priority:
- Extending test coverage. The interactor and presenter of each scene should really have tests. A simple UI test could covering the navigation from menu to details view and back again could also be justified.
- Extending dependency injection. A few classes are tied directly to an object type instead of an interface, such as the interactors being tied to the downloaders + parsers. These should be changed to an interface and injected, which would greatly aid in the above mentioned testing.
- Error handling. Currently, the application is mostly tied to the happy path, with little consideration for problems that could arise in the real world like connectivity issues, bad JSON data formats, ect.
- The UI. It hasn't been designed to be compatible with all possible devices. It's also not pretty, but it works.
