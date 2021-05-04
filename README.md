#Brewery Application

##What It Does

The brewery application creates a menu of available beers based on a set of customer preferences, and displays details about those beers to the user.


## How Does It Work?

The application loads a data file, which indicates:
 - The number of beers to brew
 - The preferences of each customer, showing which beers they prefer and in which style (classic or barrel aged)

From that a menu with beers from 1->n is produced. Because we want to minimise the number of barrel aged beers we need to create in order to satisfy everyone, we start with a menu that is entirely classic. We then loop through all the possible menus with increasing numbers of barrel aged beers to until we find a menu that satisfies all the customers. Because we're checking in this order, we can be confident that we're only producing as many barrel aged beers as is required. If we exhaust all options and still haven't found a satisfactory menu, we know a solution isn't possible.
