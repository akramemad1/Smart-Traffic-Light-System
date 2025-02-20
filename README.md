# Smart-Traffic-Light-System
Smart Traffic Light System With Verilog
Smart Traffic Light System aims to control the time of waiting depending on the traffic flow of our streets. By sensing each road we can determine whether the road is Empty, Jammed and non-jammed. That’s the data needed to control our traffic light.

## Implementation
To implement this algorithm, we applied the concept of FSM 
(Finate State Machine) to identify each state and its changes. 
- For each road we have 2 sensors, one at the beginning and the other at some distance from the first sensor, where we can detect: 
  - The road is empty. 
  - The road is Jammed. 
  - The road is neither empty nor jammed. 
- At the beginning of the system, Road X1and X2 will be allowed to move for a short time then changes to yellow then red 
- The system checks the sensor inputs in the yellow state and determine whether the controller lid the red led for a short time or a long time 
- We open both X1 and X2 at the same time or Y1 and Y2 at the same time 
- Although our effort to reduce car accidents, there’s no guarantee that car accidents will not happen, that’s why we added a reset signal which turn all the red LEDs to block the streets. 
- Y1,Y2 is now opened and X1.X2 are closed 
- At the yellow state of Y1,Y2 The same sensor check happens to determine the waiting time at the red state (Long wait or short wait). 
