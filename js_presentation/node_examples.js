"use strict"
var prompt = require('prompt');

var FS = require('fs');

prompt.start();

console.log("Javascript in the terminal using V8!\n");

console.log("Examples: \n 1: let example\n 2: eval example \n 3: promise example");

prompt.get(['input'], function (err, result) {
    if (err) { return onErr(err); }

    if(result.input == "1")
      letExample();
    else if(result.input == "2")
    {
      prompt.get(['number'], function (err, result2) {
        evalExample(result2.number);
      });
    }
    else if(result.input == "3")
      promiseExample();
    else
      console.log("woops");
});

//examples
function letExample()
{
  if(true)
  {
    var varVariable = 100;
    let letVariable = 100;
    console.log("In block\n-------------");
    console.log("varVariable is " + varVariable);
    console.log("letVariable is " + letVariable);
  }
  console.log("Outside of block\n-------------");
  console.log("varVariable is " + varVariable);
  console.log("letVariable is " + letVariable);
}

function evalExample(integerAsString)
{
  var a = eval("2 * 2 * " + integerAsString);
  var b = a * 10;
  console.log(b);

  var someObject = eval("({someData: \"I am some data inside an object\"})");
  console.log(someObject.someData);
}

function promiseExample()
{
  console.log("The server is serving users and minding its own business.")
  //pretend this is a ton of computations and database writes
  FS.readFile('war_of_the_worlds.txt', 'utf8', function(err, data) {
      if (err) throw err;
      console.log('FINISHED!: \n', data.split(/\r\n|\r|\n/).length);
  });
  console.log("Continuing server operations as normal...")

  for(var i = 1; i <= 10; i++)
  {
    console.log("serving users");
  }

}

//helpers
function onErr(err) {
    console.log(err);
    return 1;
}
