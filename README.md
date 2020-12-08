# Tan_CodingChallenge

# UI

The app was created with a grid design using UICollectionView. I Added a HeaderView to show the Date and Time of the user's last visit.

## Architecture: MVVM-C

The architectural pattern I used in this app is MVVM-C.
I used this architecture because aside from it is what I'm used to, this architecture clearly distributes the responsibilities of each classes.

- Model = handles all data objects
- View = handles all UI or what the user's see and interacts with
- ViewModel = notifies the View if there's any changes in Model
- Coordinator = handles the navigation between views/screens

## Persistence

The app saves all tracks that were retrieved when the app has started.

The persistence framework used in this app is RealmSwift.
I used this framework because it is where I am comfortable with compared to CoreData.
In my personal experience, RealmSwift was easier to learn and easier to implement because of their specific documentations.

In downloading and saving images, I used the Kingfisher swift library.

For saving the user's Date and Time of last visit, I make use of the the app's UserDefaults because the data stored is not really that complicated and sensitive.


