# Solidity Tweeter DApp

## Overview

This repository contains a Solidity smart contract for a decentralized Twitter-like application. The contract allows users to create tweets, like/unlike tweets, and view tweets. Additionally, the contract owner has the ability to set the maximum length of tweets.

## Key Features

### Tweet Creation

Users can create tweets with a character limit set by the contract owner. This mimics the functionality of Twitter, where users can share their thoughts within a specified limit.

### Tweet Interactions

Users can like and unlike tweets, enabling social interaction within the platform. Each tweet keeps track of its like count, which can be queried.

### Tweet Management

The contract allows users to retrieve individual tweets or all tweets created by a specific user. Additionally, the contract owner can change the maximum allowed tweet length, providing flexibility to the platform's content management.

## Smart Contract Components

### State Variables

- **MAX_TWEET_LENGTH**: This variable sets the maximum number of characters allowed in a tweet. Initially, it is set to 280 characters but can be changed by the contract owner.
- **tweets**: This mapping stores all tweets, organized by the author's address. Each user can have multiple tweets, stored in an array.

### Structs

- **Tweet**: This struct represents a tweet and contains:
  - `id`: Unique identifier for the tweet.
  - `author`: Address of the tweet's author.
  - `content`: The text content of the tweet.
  - `timestamp`: The time when the tweet was created.
  - `likes`: The number of likes the tweet has received.

### Events

Events are used to log significant actions within the contract:

- **TweetCreated**: Emitted when a new tweet is created.
- **TweetLiked**: Emitted when a tweet is liked.
- **TweetUnliked**: Emitted when a tweet is unliked.

### Functions

#### Constructor

The constructor initializes the contract, setting the initial owner.

#### changeTweetLength

This function allows the contract owner to change the maximum tweet length. This is useful for adapting the platform's rules without redeploying the contract.

#### getTotalLikes

This function returns the total number of likes for all tweets by a specific author. It iterates through the author's tweets and sums the likes.

#### createTweet

This function allows a user to create a new tweet. It checks that the tweet content does not exceed the maximum length and then stores the tweet in the `tweets` mapping.

#### likeTweet

This function allows a user to like a tweet. It increases the like count of the specified tweet and emits a `TweetLiked` event.

#### unlikeTweet

This function allows a user to unlike a tweet they have previously liked. It decreases the like count of the specified tweet and emits a `TweetUnliked` event.

#### getTweet

This function retrieves a specific tweet by its index within the user's tweet array. This is useful for viewing individual tweets.

#### getAllTweets

This function returns all tweets created by a specific user. It provides an overview of a user's activity on the platform.

## Usage

### Deployment

To deploy the contract, follow these steps:

1. Clone the repository:
```bash
git clone https://github.com/yourusername/solidity-tweeter-Dapp.git
cd solidity-tweeter-Dapp
```

2. Install dependencies:
```bash
npm install
```

3. Compile the contract:
```bash
npx hardhat compile
```

4. Deploy the contract:
```bash
npx hardhat run scripts/deploy.js
```

### Interaction

Once deployed, you can interact with the contract using a frontend interface or directly through the blockchain. The functions provided allow you to create, like, unlike, and retrieve tweets.

## Contributing

Contributions are welcome! To contribute, follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new Pull Request.

## Author

- Abubakar Zia (abu.bakar.zia146@proton.me)

Feel free to reach out if you have any questions or suggestions!

---
