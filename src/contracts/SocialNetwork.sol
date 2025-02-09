pragma solidity ^0.5.0;
 
contract SocialNetwork {
  string public name;
  uint public postCount = 0;
  mapping (uint => Post) public posts; 

  struct Post {
    uint id;
    string content;
    uint tipAmount;
    address payable author;
  }

  event PostCreated(uint id, string content, uint tipAmount, address payable author);
  event PostTipped(uint id, string content, uint tipAmount, address payable author);
  
  constructor() public {
    name = "Social network";
  }

  function createPost(string memory _content) public {
    require(bytes(_content).length > 0);
    postCount++;
    posts[postCount] = Post(postCount, _content, 0, msg.sender);
    emit PostCreated(postCount, _content, 0, msg.sender);
  }

  function tipPost(uint _id) public payable {
    require(_id > 0 && _id <= postCount);
    Post memory _post = posts[_id];
    address payable _author = _post.author;
    address(_author).transfer(msg.value);
    _post.tipAmount += msg.value;
    posts[_id] = _post;
    emit PostCreated(postCount, _post.content, msg.value, msg.sender);
  }
}