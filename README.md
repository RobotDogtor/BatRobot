## BatRobot Optimization Code

Each step of the design should have a base functioning setup. Easy practicality vs dreams. Flat wings for now and then we do curved wings later


**Goal:** Have a integrated system for designing different wing shapes and motions to get the flying behavior we want. 

### Big Ideas
 - The wings don't have to be flat, we can make them curved like an actual bats.
 - Bats don't flap down and straight, they have a more circular, full body motion (talk to bat crew)
 - Bats have increased maneuverability and efficiency from their articulated hands. How to build the most important parts of that into the wing. 
 - Look at multiple degrees of Freedom

### Steps
1. Yohan has a new design of multiple gears which should: isolate the flapping and folding actions, simplify the number of variables for flapping and folding.
2. In the code connect the design of the mechanism and the wings in order to get the motions we want.
3. Setup an optimizaiton


## Code Details

There are three independent variables that define a flapping motion for a single DOF wing. The wing angle alpha (zero is arms straight out) and the shoulder distance beta (distance from wp1 to wp2.