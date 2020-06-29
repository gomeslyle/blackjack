# blackjack

First time ever writing a Swift XCode app. Runs on Mac OS desktop. Compiles in XCode 9.0 on High Sierra 10.13.1. The UI is made using TextViews, ImageViews, relationships, etc. It was very simple and intuitive using XCode's drag and connect feature.
I feel alright with the end-result.

I am not too familiar with the rules of Blackjack (especially the win conditions for both dealer & player). If I made an error somewhere please point it out to me and I will make adjustments if necessary.

Regarding the requirements:

1. Dealer hits on a soft-17.

2. Game features a single deck that is shuffled every 6 hands. Simple modulus operator to keep track of every 6th hand. The Shuffle algorthim is from a gentleman named Victor Wooding. He uploaded a short but informative video on how to shuffle an array in the Swift language. Ideally I would be using Fisher-Yates algorithm to shuffle the deck. Strange phenomenom occurs when using the above algorithm; the Ace of Spades is always at the end of the deck. I am assumming it is the Ace of Spades that is the card in question; because it is the highest ranking card in both suit and value (i.e. the last inserted into the deck array after the constructor is called). So 51 of the 52 cards have swapped indices except the last card that is entered into the deck during class instantiation (i.e. after constructor is called). But anyways, algorithm adjustment would remedy the issue.

3. Player cannot split cards.

4. Win fraction is displayed to the player.

5. Compiled on a Mac using XCode.

Improvements:

1. There are two functions that carry the most of the same code and logic. They can be put into helper functions to increase code readability and reduce redundancy
(findResultOfMatchAfterPlayerHits() as well as findResultOfMatchAfterStands()).

2. More source files should be added to group similar functionality together. Collaborating developers can read a single file and expect similar functionality from within a single file.

3. I did not write Unit tests; but here is an interesting one I thought of:
    - Generate a large list of a possible soft-17 hands and check to see if the Dealer AI recognizes to hit when encountering these hands.

Citations:
 1. Victor Wooding's shuffling algorithm: https://www.youtube.com/watch?v=5hlw-KGfXtY
 2. Playing card PNG's obtained from here: http://acbl.mybigcommerce.com/52-playing-cards/
 3. BlackJack logo: https://iconscout.com/icon/black-jack-2038478
 4. I got the idea of using enumerating ranks and suits in Card classes from this blog post: https://www.associatedtype.net/2017/09/first-steps-with-swift-representing-cards-in-a-deck/
 5. I read a bit about Blackjack soft-17's on this webpage: http://www.readybetgo.com/blackjack/strategy/soft-17-rule-2496.html#:~:text=Any%20blackjack%20hand%20that%20contains,than%20their%20corresponding%20hard%20hands

Other than that, I pretty much wrote all the code myself (apart from anything & everything I searched up on Stackoverflow and Apple API documentation, but that was simply syntax and methods for standard Mac OS UI elements) except for the shuffle algorithm. But that's probably expected seeing as it's more a logical exercise as opposed to anything else.
