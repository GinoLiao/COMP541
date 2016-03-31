% 3D DTW algorithm Unit Test

clear;
close all;
clc;

t = zeros(100,3);

% test 0 - same data
for i = 1:100
    for j = 1:3
        t(i,j) = i;
    end
end

% totally the same array
[Dist, D, k, w] = dtw(t,t);
disp('TEST0: same linear data');
disp(Dist);

% test 1 - reverse linear data
for i = 1:100
    for j = 1:3
        r(i,j) = 101-i;
    end
end

[Dist, D, k, w] = dtw(t,r);
disp('TEST1: reverse linear data');
disp(Dist);

% test 2 - -1 linear data
r = zeros(100,3);
for i = 1:100
    for j = 1:3
        r(i,j) = i-1;
    end
end

[Dist, D, k, w] = dtw(t,r);
disp('TEST2: -1 linear data');
disp(Dist);

% test 3 - +1 linear data
r = zeros(100,3);
for i = 1:100
    for j = 1:3
        r(i,j) = i+1;
    end
end

[Dist, D, k, w] = dtw(t,r);
disp('TEST3: +1 linear data');
disp(Dist);

% test 4 - same data in half length
z = zeros(50,3);
for i = 1:100
    for j = 1:3
        z(i,j) = i+1;
    end
end

[Dist, D, k, w] = dtw(z,r);
disp('TEST4: same data but half length');
disp(Dist);

% test 5 - -1 linear data in half length
for i = 1:100
    for j = 1:3
        z(i,j) = i;
    end
end

[Dist, D, k, w] = dtw(z,r);
disp('TEST5: -1 linear data and half length');
disp(Dist);

% test 6 - both pseudorandom data (max 100)
for i = 1:100
    for j = 1:3
        r(i,j) = randi(100);
        t(i,j) = randi(100);
    end
end

[Dist, D, k, w] = dtw(t,r);
disp('TEST6: both pseudorandom data (max 100)');
disp(Dist);
