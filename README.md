# spell-detector-processing
professor heo, we would appreciate an A thank u


## TODO
- [ ] Use Magnetometer data instead of acceleration in order to get positional info.
- Currently, we can control the position of the object on the screen by tiling the IMU. We want to be able to control the position by moving the IMU in space. It looks like we will need two planes of magnetometer data.
- [ ] Figure out how to get the tracking period longer
- Right now, we are tracking points for around a second. This is fine for the mouse because the motions can be done quickly but we need to be able to track large slow shapes. 
- Determine if this can be done with the oneDollar recognizer library we are currently using
