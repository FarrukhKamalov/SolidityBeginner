// SPDX-License-Identifier: MIT

import  "@openzeppelin/contracts/access/Ownable.sol";
pragma solidity ^0.8.0;



interface IProfile {
    struct UserProfile {
        string displayName;
        string bio;
    } 

    function getProfile(address _user) external view returns(UserProfile memory);

}

contract Twitter is Ownable {

    uint public MAX_TWEET_LENGTH = 280;

    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;

    IProfile public profileContract;
   
    event TweetCreated(
        uint256 id,
        address author,
        string content,
        uint256 timestamp
    );

    event TweetLiked(
        address liker,
        address tweetAuthor,
        uint256 tweetId,
        uint256 newLikeCount
    );

    event TweetUnLiked(
        address unliker,
        address tweetAuthor,
        uint256 tweetId,
        uint256 newLikeCount
    );
    
    modifier onlyRegistered(){
        IProfile.UserProfile memory userProfileTemp = profileContract.getProfile(msg.sender);
        _;
    }

    constructor(address _profileContract) onlyOwner() {
        profileContract = IProfile(_profileContract);
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function getTotalLikes(address _author) external view  returns(uint){
        uint totalLikes;

        for (uint i = 0; i < tweets[_author].length; i++){
            totalLikes += tweets[_author][i].likes;
        }
        return totalLikes;
    }

    function createTweet(string memory _tweet) public {
        require(
            bytes(_tweet).length <= MAX_TWEET_LENGTH,
            "Tweet juda uzun brooo!"
        );

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);

        emit TweetCreated(
            newTweet.id,
            newTweet.author,
            newTweet.content,
            newTweet.timestamp
        );
    }

    function likeTweet(address _author, uint256 _id) external onlyRegistered {
        require(tweets[_author][_id].id == _id, "Id ga tegishli Tweet yoq");

        tweets[_author][_id].likes++;

        emit TweetLiked(msg.sender, _author, _id, tweets[_author][_id].likes);
    }

    function unLikeTweet(address _author, uint _id) external onlyRegistered {
        require(tweets[_author][_id].id == _id, "Id ga tegishli Tweet yoq");
        require(
            tweets[_author][_id].likes > 0,
            "Like yoqku brat yana dislike qimoqchi bolasiza brooooooooooooo!"
        );

        tweets[_author][_id].likes--;
        emit TweetLiked(msg.sender, _author, _id, tweets[_author][_id].likes);
    }

    function getTweet(
        address _owner,
        uint _i
    ) public view returns (Tweet memory) {
        return tweets[_owner][_i];
    }

    function getAllTweet(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
