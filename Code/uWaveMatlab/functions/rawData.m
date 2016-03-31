


%% 
% Use MATLAB Connector to allow connection between your desktop MATLAB 
% session and MATLAB Mobile on your Android device. Your device must be 
% able to connect to your desktop, either by being on the same network, 
% using a VPN, or through a similar configuration.
%
% Execute the |connector| command with a password of your choice.
% password is set to 123456 right now

connector on 123456;

%% Create a link to your mobile device
% Use the |mobiledev| command to create an object that represents your
% mobile device.
m = mobiledev;

%% Prepare for data acquisition
% Enable the acceleration sensor on the device.

m.AccelerationSensorEnabled = 1;

%% Start acquiring data
% After enabling the sensor, the Sensors screen of MATLAB Mobile will show
% the current data measured by the sensor. The |Logging| property allows 
% you to begin sending sensor data to |mobiledev|.
m.SampleRate = 1000;

%pop up window and listen to user's keyboard input to start logging data
h = msgbox('Press any key to start.');
set(h, 'Position', [20 400 120 50]);
% f = figure;
% f.Name = 'Press any key to start';
% set(f, 'Position', [100 200 400 400]);

w1 = waitforbuttonpress;
if w1
    m.Logging = 1;
end

%%
% The device is now transmitting sensor data. Wait for another user input
% to stop.

h = msgbox('Press any key to end capturing your gesture.');
set(h, 'Position', [20 400 180 50]);
% f = figure;
% f.Name = 'Press any key to start';
% set(f, 'Position', [100 200 400 400]);
w2 = waitforbuttonpress;

%% Stop acquiring data
% The |Logging| property is used to again to have the device stop sending
% sensor data to |mobiledev|.
if w2
    m.Logging = 0;
end      




%% Retrieve logged data
% |accellog| is used to retrieve the XYZ acceleration data and timestamps
% transmitted from the devicce to |mobiledev|.

[a, t] = accellog(m);


%% Plot raw sensor data
% The logged acceleration data for all three axes can be plotted together.

plot(t, a);
legend('X', 'Y', 'Z');
xlabel('Relative time (s)');
ylabel('Acceleration (m/s^2)');




%% Clean up
% Turn off the acceleration sensor and clear |mobiledev|.

m.AccelerationSensorEnabled = 0;
clear m;
clear w1;
clear w2;
connector off;

