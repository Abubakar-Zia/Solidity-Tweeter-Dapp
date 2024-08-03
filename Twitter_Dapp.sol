// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Twitter is Ownable {

    uint16 public MAX_TWEET_LENGTH = 280;

// Constructor to pass the initial owner to the Ownable constructor
    constructor(address initialOwner) Ownable(initialOwner) {
        // Additional initialization code if needed
    }

    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }
    
    mapping(address => Tweet[]) public tweets;

    // Define the events
    event TweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event TweetLiked(address liker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);
    event TweetUnliked(address unliker, address tweetAuthor, uint256 tweetId, uint256 newLikeCount);

    // Function to change the maximum tweet length, restricted to the owner
    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    // Function to get the total likes of all tweets by a specific author
    function getTotalLikes(address _author) external view returns(uint) {
        uint totalLikes;

        for (uint i = 0; i < tweets[_author].length; i++) {
            totalLikes += tweets[_author][i].likes;
        }

        return totalLikes;
    }

    // Function to create a new tweet
    function createTweet(string memory _tweet) public {
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long!");

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);

        // Emit the TweetCreated event
        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
    }

    // Function to like a tweet
    function likeTweet(address author, uint256 id) external {  
        require(tweets[author][id].id == id, "Tweet does not exist");

        tweets[author][id].likes++;

        // Emit the TweetLiked event
        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    // Function to unlike a tweet
    function unlikeTweet(address author, uint256 id) external {
        require(tweets[author][id].id == id, "Tweet does not exist");
        require(tweets[author][id].likes > 0, "Tweet has no likes");
        
        tweets[author][id].likes--;

        emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
    }

    // Function to get a specific tweet by index
    function getTweet(uint _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    // Function to get all tweets by a specific owner
    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
