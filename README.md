# CrosswordSolver

A simple iOS app to assist with completing crosswords. The user can adjust the number of textboxes to the number of letters required, fill in the characters they know and then search for results.

The list of words used in the app was gathered from: https://github.com/dwyl/english-words

Note: When running the app for the first time the word list is loaded into Realm. Being over 300,000 words it takes a couple seconds, but I've managed to reduce it from what it was before and added a little loader screen.

## Features

- Uses system fonts so will respond to dynamic text sizes
- Supports dark mode
- Set the length of the word and input the known characters
- Quickly receive the list of fitting words due to all words being available locally

### Possible future features

- Tapping on a word will load a dictionary definition from a free API
- Finish the SearchController (?)
- Suggest/add missing words

## Development

If you'd like to contribute, tweak or fix anything, please feel free to!

1. Clone the repository and run `pod install` to install the libraries.
2. Run the target

## Known issues

1. The predicate for searching Realm in CompleteWordController isn't very accurate as it uses wildcards for the unknown characters which don't respect the positions on the known characters.
This means searching for `D` `?` `E` `?` `?` could return `DAMES`, as there is no limit between the known characters.
2. The `SearchController` screen is incomplete and not visible, and I'm not sure if I will finish it just yet as the CompleteWordController is basically an advanced search anyways.
