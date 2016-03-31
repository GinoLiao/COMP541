
%
% [a1, t1] = accellog(m);

[tout1,Q1] = uWaveQuant(t,a);

data1 = uWaveLeveling(Q1);


% [a2, t2] = accellog(n);

[tout2,Q2] = uWaveQuant(t2,a2);

data2 = uWaveLeveling(Q2);


[Dist,D,k,w] = dtw(data2,data1);


disp(Dist);




