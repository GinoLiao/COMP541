% plot distance matrix
gino_ges = zeros(4,10);
henry_ges = zeros(4,10);
for ges = 1:4
    for at=1:10
       gino_ges(ges, at) = distanceMatrix(1,ges,at);
       henry_ges(ges, at) = distanceMatrix(2,ges,at);
    end
end
att = [1,2,3,4,5,6,7,8,9,10];

figure
subplot(2,2,1)  
hold all
plot(att, gino_ges(1,:), '-o');
plot(att, henry_ges(1,:),'-o');
legend('Prover Gesture 1','Attacker Gesture 1');
xlabel('Attempt Number');
ylabel('DTW Distance');
title('DTW Distance to Verifier');

hold

subplot(2,2,2)  
hold all
plot(att, gino_ges(2,:), '-o');
plot(att, henry_ges(2,:),'-o');
legend('Prover Gesture 2','Attacker Gesture 2');
xlabel('Attempt Number');
ylabel('DTW Distance');
title('DTW Distance to Verifier');

hold

subplot(2,2,3)  
hold all
plot(att, gino_ges(3,:), '-o');
plot(att, henry_ges(3,:),'-o');
legend('Prover Gesture 3','Attacker Gesture 3');
xlabel('Attempt Number');
ylabel('DTW Distance');
title('DTW Distance to Verifier');

hold

subplot(2,2,4)  
hold all
plot(att, gino_ges(4,:), '-o');
plot(att, henry_ges(4,:),'-o');
legend('Prover Gesture 4','Attacker Gesture 4');
xlabel('Attempt Number');
ylabel('DTW Distance');
title('DTW Distance to Verifier');