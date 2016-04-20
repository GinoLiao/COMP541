
fid = fopen('m1/s2.txt', 'rt');
C = textscan(fid, '%f64 %f %f %f %f %s', 'Delimiter', ',');
fclose(fid);

tPebble = ( C{1} - C{1}(1) ) * 10e-4;
aPebble = [C{2} C{3} C{4}];

for i=1:length(C{1})
  aPebble(i,:) = [-C{2}(i)/100 -C{3}(i)/100 -C{4}(i)/100];
end


[tout1,Q1] = uWaveQuant(tPebble,aPebble);
data1 = uWaveLeveling(Q1);



[tout2,Q2] = uWaveQuant(t,a);
data2 = uWaveLeveling(Q2);   %accel from phone



[Dist,D,k,w] = dtw(data2,data1);
disp(Dist);


figure
subplot(2,1,1)       % add first plot in 2 x 1 grid
plot(t, a);
legend('X', 'Y', 'Z');
xlabel('Relative time (s)');
ylabel('Acceleration (m/s^2)');
title('Smartphone');



subplot(2,1,2)       % add first plot in 2 x 1 grid
plot(tPebble, aPebble);
legend('X', 'Y', 'Z');
xlabel('Relative time (s)');
ylabel('Acceleration (m/s^2)');
title('Pebble');



%Q L
%e2:33830
%4-7/henry_e_9 and e2 73097
%s1:24175
%s2:21906
%4-13/henry_s_7 and s1 31100
%4-13/henry_s_7 and s2 33994
%4-13/jeo_s_2 and s1 48641
%4-13/joe_s_2 and s2 40092








