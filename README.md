Reading through learn [you a haskell for great good](http://learnyouahaskell.com/)
and in the input and output section he has you make a todo list. This is that list
largely copied from the book, however the remove/bump functions I wrote my self
with the alterLine function reflecting much of what the 'remove' function of the
book has for it's body. 

Primarily modified it to allow for the bump function which takes an item number
and bumps it to the top of the list. In doing so I saw that both and bump and 
remove shared a lot of code, so pull it out and decided to try out partial applicatoin
which you can see that both bump ad remove partially apply alterLine satisfying 
the first parameter which will return a function with the signature of

`[String] -> IO ()`

which happens to be the signature for the those functions. Since that matches 
nothing else needs to be done, I can simply just declare those two functions as 
I did. 

Really enjoying this language.
