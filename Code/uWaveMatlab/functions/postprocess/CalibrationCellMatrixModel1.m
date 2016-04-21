function cm = CalibrationCellMatrixModel1(totalGestures, numRuns)
    cm = cell(totalGestures, numRuns);

    fileMat = {'Num8' 'Gesture7' 'ru' 'Gesture17'};

    for gesInd =  1:totalGestures
       display(['gesture index:' num2str(gesInd)]);
       for attempts = 1:numRuns
            filename = strcat('model1/Android&Pebble/', fileMat{gesInd}, '_', num2str(attempts), '.txt');
            display(['filename:' filename]);
            fid = fopen( filename, 'rt');
            C = textscan(fid, '%f64 %f %f %f %f %s', 'Delimiter', ',');
            fclose(fid);
            tPebble = ( C{1} - C{1}(1) ) * 10e-4;
            aPebble = [C{2} C{3} C{4}];
            for i=1:length(C{1})
              aPebble(i,:) = [-C{2}(i)/100 -C{3}(i)/100 -C{4}(i)/100];
            end
            [~,Q_aPebble] = uWaveQuant(tPebble,aPebble);
            QL_aPebble = uWaveLeveling(Q_aPebble);
%             disp(QL_aPebble);
            cm{gesInd,attempts} = QL_aPebble;
       end
    end

end