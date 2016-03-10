var passport = require('passport');
var Ladder = require('../models/Ladder');
var User = require('../models/User');
var secrets = require('../config/secrets');

var tokenLib = require('random-token');

var ActiveUser = function (userName, subUntil) {
  var curTime = Date.now();
  this.userName = userName;
  if(subUntil == undefined)
    this.subUntil = 0;
  else
    this.subUntil = subUntil;
  this.lastActivity = curTime;
  this.privateChats = [];
  this.authToken = undefined;
  this.setAuthToken();
  this.lobbyLocation = '';
  this.retokenFlag = false;
  this.hasResponded = true;
  this.visitedThisSession = {};

  this.lastMsgTime = curTime;
  this.recentMsgCount = 0;

  this.mutedUntil = 0;

  this.maxPremuteMessages = 8;
  this.muteDurration = 5000;

  this.currentLadder = '';

  sendableUsers.push(userName);
};

//returns number of chats de facto or -1 if chat already there;
ActiveUser.prototype.attemptEnterPrivate = function(chatName)
{
  if(this.privateChats.indexOf(chatName) != -1)
    return -1;
  this.privateChats.push(chatName);

  console.log("adderafter: " + JSON.stringify(this.privateChats));
  return this.privateChats.length;
};

//returns number of chats de facto or -1 if chat not there;
ActiveUser.prototype.attemptLeavePrivate = function(chatName)
{
  var index = this.privateChats.indexOf(chatName);
  if(index == -1)
    return -1;
  this.privateChats.splice(index, 1);
  return this.privateChats.length;
};

ActiveUser.prototype.setLobbyLocation = function(urlSubString)
{
  this.lobbyLocation = urlSubString;
};

ActiveUser.prototype.clearLobbyLocation = function()
{
  this.lobbyLocation = '';
};

ActiveUser.prototype.setAuthToken = function()
{
  this.authToken = tokenLib(16);
};


ActiveUser.prototype.getAuthToken = function()
{
  this.updateTimestamp();
  return this.authToken;
};

ActiveUser.prototype.updateTimestamp = function()
{
  this.lastActivity = Date.now();
};

ActiveUser.prototype.getTimestamp = function()
{
  return this.lastActivity;
};

ActiveUser.prototype.getSubUntil = function()
{
  return this.subUntil;
};


ActiveUser.prototype.primeRetoken = function()
{
  this.retokenFlag = true;
};


ActiveUser.prototype.retoken = function()
{
  if(this.retokenFlag)
  {
    this.setAuthToken();
    this.retokenFlag = false;
  }
};

exports.ActiveUser = ActiveUser;
