# blackjack

General Swift XCode Cocoa app. Runs on Mac OS desktop. Compile in XCode 9.0.

Shuffle algorthim is from Victor Wooding's YouTube Video:
https://www.youtube.com/watch?v=5hlw-KGfXtY

Ideally I would be using Fisher-Yates algorithm to shuffle the deck. Strange phenomenom occurs when using the above algorithm; the Ace of Spades is always at the end of the deck.
It is the Ace of Spades because it is the highest ranking card in both suit and value. I am assumming that because it is the last card to be shuffled, that there is no
place for it to entered into the deck. So 51 of the 52 cards have swapped indices except the last card that is entered into the deck during class instantiation (i.e. after
constructor is called).

The BlackJack UI is made using TextViews, ImageViews, relationships, etc. Was very simple and intuitive using XCode drag and connect UI.

Improvements:
There are two functions that use the most of the same code and logic. They can be put into helper functions to increase code readability and reduce redundancy
(findResultOfMatchAfterPlayerHits() as well as findResultOfMatchAfterStands()).

More source files should be added to group similar functionality together. Developers can read a single file and expect similar concepts within a single file.

I did not write Unit tests; but here is a really good one I thought of:
  x. Generate a large list of a possible soft-17 hands and check to see if the Dealer AI recognizes to hit when encountering these hands.
