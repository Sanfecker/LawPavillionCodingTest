# LawPavillionCodingTest


The SwiftUI Framework was used for this project.

I used the MVVM architecture.

I have a Model holding my data Model.

The ViewModel class holds the logic for the app.. The network call to GitHub is also made here.

The ViewModel class is Observable and is hosted by the ContentView struct and the same instance is passed to the other view components that make up the UI flow.

In order to get data from the GitHub API and paginate using a 10 per page count.. I added the "page" and "per_page" parameters to the url .

Using a LazyVStack.. I can defer loading up data in memory until the data is needed while scrolling so.. I monitor the scrolling to the last item on the list and then i update the page state variable on my view model.. which calls the getItem function that updates the list.

Everytime a search is made.. the page state variable is reset and the list is updates as required.

The results gotten after API call are not sorted and i couldn't find a sort parameter that performs the requested functionality as stated on the Excercise sheet as follows "The results must be sorted alphabetically by login". 

The results are sorted per page as they are returned before they are added to the list of items to be displayed on the UI.
