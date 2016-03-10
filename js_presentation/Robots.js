
function Robot(name, powerSource, requestAssistance){
  this.name = name;
  this.powerSource = powerSource;
  this.requestAssistance = requestAssistance;
}

//an array would typically be more ideal
var myRobots = {};

myRobots.firstRobot = new Robot("Rosie", "Electric Battery", function(){
  console.log(this.name + " replies: Sure thing Mr.Jetson!");
});

myRobots.secondRobot = new Robot("Bender", "Beer", function(){
  console.log(this.name + " replies: Hahaha *burps fire*");
});

for(robotKey in myRobots)
{
  var thisRobot = myRobots[robotKey];
  console.log(thisRobot.name + " is powered by: " + thisRobot.powerSource);
  console.log("Asking " + thisRobot.name + " for help...");
  thisRobot.requestAssistance();
  console.log("-----------------------------");
}
