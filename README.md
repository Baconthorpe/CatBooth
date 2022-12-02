Photobooth Supply Company Code Challenge
========================================
Zeke Abuhoff
============

Setup
-----

A computer with up-to-date Xcode should be able to build and run the project just fine. No special setup required.

Design Choices
--------------

I opted to keep this project simple. Generally, I find that doing a task as described is best, without getting bogged down in optional bells and whistles. I would rather deliver the essentials in a timely manner than delay completion by a few days for features that may not even be desired.

To that end, the app I've built is bare-bones. It displays ten random images of cats retrieved from the Cat-as-a-Service API. This limited functionality doesn't require a private API key, which simplifies the networking code and security considerations (since API keys and secrets are generally considered sensitive information, potentially warranting keeping that information outside of what's checked into the repo). Keeping the app to one screen saves me the trouble of navigation code.

But that shouldn't be taken to mean that the code isn't carefully written. I've endeavored to execute each aspect of the simple functionality with the sort of attention to detail I would apply in production code. I've been interested recently in SwiftUI and Combine, especially used together, and figured this would be a fine showcase for design patterns using those frameworks. They lend themselves to a MVVM architecture, neatly dividing function into model, view and viewmodel layers. It's the sort of contemporary iOS code I would encourage a new project to use.

The model layer is quite lean - only concerned with making network calls to the CATAAS API. In larger projects, I'd likely pull general-use network code out into its own type, but here that seemed like a premature abstraction. The public methods return `AnyPublisher` instances associated with the appropriate data types, so that code in the viewmodel layer can subscribe to the arrival of fetched data.

The viewmodel types exist to engage with the network code of the model layer and provide a straightforward interface for the view layer. This is arguably overkill for such a small project, but maintaining the proper roles of the architecture's layers is so frequently important for every bigger project that it seemed to me a misrepresentation of how I write code to leave out the middleman.

In `CatListViewModel` and `CatImageViewModel` you can see two different approaches I tried to facilitating previews and testability in the viewmodel. For `CatListViewModel`, I used a protocol to make the live and preview/testing implementations interchangeable. This seems elegant to me in terms of the types, but it adds a little bit of generic type specification to the corresponding view, so the approach is not entirely free of clutter. Conversely, in `CatImageViewModel`, I tried using one type with an alternate instantiating method for preview/test scenarios. Using one type has pleasing simplicity, but I wonder if some viewmodel types would be awkward to write if they have to accomodate an alternate configuration for testing and previews.

The views of the app are nothing fancy but they do demonstrate a pretty clean, clear way of connecting views to Combine-managed data using `@ObservedObject` and `@State`.

Potential Improvements
----------------------

Part of building within a tight scope is recognizing what additional functionality could be added in the future. If I were to continue working on this app, there's a lot I could do to make it bigger and better.

While it's not entirely clear what features a user would want from this app, it's not hard to imagine more sophisticated use of API features being made accessible to the user. By incorporating use of an API key into the `CatAPI` type, I could retrieve more than 10 images at a time and use search terms. These parameters could be surfaced to the user through text fields in the UI, possibly alongside the scrollable list so that it's always available.

I could also advance the architecture to facilitate further development. The networking boilerplate could be abstracted into its own type out of `CatAPI` and generics could be used to provide a reusable superclass for viewmodels (so that each viewmodel file would just include code specifically about the transformations necessary for that data).

I would want to flesh out the preview and testing aspects of the project. With further tweaking and elaboration, the previews could be more informative for each view. As functionality gets more complex, unit tests and UI tests would likely be quite helpful.

I find SwiftUI and Combine quite interesting, so I'd be happy to expand on a project like this. I just didn't want to take too long completing the project just to explore additional features that may not even be of interest to you folks. And I think smart development aggressively pursues tight scope anyway.
