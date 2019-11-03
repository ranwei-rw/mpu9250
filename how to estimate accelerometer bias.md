info: 

How to get better of accelerometer bias estimation?

Place Arduino + IMU9250 onto a surface, make sure it rests still. Measure a series of readings A1

Rotate IMU9250 horizontally by 180 degree and measure another series of readings A2

From A1 and A2 we can have two averaged estimations MA1 and MA2

For MA1 let's assume that the first element is for x reading, then
MA1(x) = cos(theta)*gxy+ bias_x. and 
MA2(x) = cos(pi + theta)*gxy + bias_x = -cos(theta)*gxy + bias_x

Similiarly, we have

MA1(y) = sin(theta)*gxy + bias_y
MA2(y) = -sin(theta)*gxy + bias_y.

Hence we have:

bias_x = (MA1(x) + MA2(x))/2 and bias_y = (MA1(y) + MA29y))/2;

aslo

cos(theta)*gxy = (MA1(x) - MA2(x))/2
sin(theta)*gxy = (MA1(y) - MA2(y))/2

As the result, the element of gravity on xy plane is determined by sqrt(cos(theta)^2 + sin(theta)^2)*gxy == gxy

since g = sqrt(gxy^2 + gz^2), gz = sqrt(1 - gxy^2) which can be used in the calibrationMPU9250 function. with will leads to better estimation of bias_z

alternatively, bias_z can be estimated by (MA1(z) + MA2(z))/2 + 1 - gz.

matlab cose: used
file = 'accelerometer_bias_d1.txt';
d1 = read_9250_output(file);
file = 'accelerometer_bias_d2.txt';
d2 = read_9250_output(file);
a1 = mean(d1);
a2 = mean(d2.bias);
biasx = (a1(1)+a2(1))/2;
biasy = (a1(2) + a2(2))/2;
costheta = a2(1) - biasx
sintheta = a2(2) - biasy
thetav = costheta^2 + sintheta^2
zvalue = sqrt(1 - thetav)
biasz = (a1(3) + a2(3))/2 + (1-zvalue);
bias =[biasx, biasx, biasz]