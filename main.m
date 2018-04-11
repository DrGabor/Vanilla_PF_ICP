clc; close all; clear all;
USE_3D = 1;
run('LoadData.m'); 
%%
np = 100;
%%%% initial particles a uniform distribution.
particles = [];
for id = 1 : 1 : np
    particles(id).w = 1/np;
end
TParticles = [];
TPara = [];
h = figure;     
L = 7;
sigma = 2.0*res;
for nIter = 1 : 1 : 30
    time_a = tic; 
    run('motionModel.m'); 
    run('updateWeight.m');
    run('getBestParticle.m'); 
    %%%% terminate condition, a little different with Sandhu, but works
    %%%% quite well. 
    if size(TPara, 2) >= 2
        if norm(TPara(:, end) - TPara(:, end-1)) <= 0.5*1e-2
            break;
        end
    end
    [optR, optT] = state2RTFun(xOpt);
    Aft = Loc2Glo(Mov, optR', optT); 
    nTime = toc(time_a); 

    X = cat(2, particles(:).xv); 
    figure(h);
    cla; 
    hold on; 
    grid on; 
    axis equal; 
    plot(Ref(1, :), Ref(2, :), 'g.');
    plot(Mov(1, :), Mov(2, :), 'r.');
    Ang = X(3, :); 
    quiver(X(1, :), X(2, :), cos(Ang), sin(Ang), 'color', 'm', ...
        'AutoScale', 'off', 'AutoScaleFactor', 5.0*res);
    plot(X(1, :), X(2, :), 'ko', 'markersize', 4); 
    
    plot(Aft(1, :), Aft(2, :), 'bo', 'markersize', 4); 
    str = sprintf('nIter = %02d, particleNum = %04d, time = %04dms', nIter, np, round(nTime*1000.0)); 
    title(str); 
    disp(str); 
    pause(0.05); 
    run('resampling.m');
    bTest = 1; 
end
if nDim == 3 
    figure; 
    hold on; 
    grid on; 
    axis equal; 
    pcshow(Ref', 'g'); 
    pcshow(Aft', 'b'); 
end

