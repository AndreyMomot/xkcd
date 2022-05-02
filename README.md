# xkcd

Description of Comics app

Implemented features:
✅ browse through the comics
✅ see the comic details, including its description,
❌ search for comics by the comic number as well as text - can't be done because https://relevantxkcd.appspot.com doesn't work
❌ get the comic explanation
✅ favorite the comics, which would be available offline too,
✅ send comics to others,
❌ get notifications when a new comic is published,
✅ support multiple form factors.

Short description of my decisions:
- I've used Swift 5 as a main language
- Project is built on top of MVVM pattern with binding between ViewModel and ViewController
- I've choose simplified Coordinator pattern for app navigation with coordinator for every module and callbacks on blocks
- API is designed on top of URLSession with help of Generics, Request has Response as associatedtype
- All models is Codable
- I've choose UserDefaults as a simplest storage, but it could be easily replaced by more elegant solution using Storable protocol
- Custom LoadableImageView has it's own Cache. It is simplified version of 3rd party sd_webimage
- Implemented few UnitTests for API, ViewModels and Coordinators

What exactly I feel proud of?
- Simple understandable MVVM + Coordinators pattern, one of the best solution for small projects like this. Bindable could be easily replaced with delegates, blocks or even RX
- API design on top of Generics with Codable is very extendable and could be use even in commercial projects
- Following SOLID principles 

What could be done better?
- For apps like this it would be useful to have search by ID
- Search mechanism by tags to display all related comicses to CollectionView
- Add Reachability to check if device goes offline - show comicese only from offline storage
- share persfomance with link to the comics


