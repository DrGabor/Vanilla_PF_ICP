rng('default');
rng(2000);
if USE_3D
    run('Data_3D.m');
else
    run('Data_2D.m');
end
nDim = size(Ref, 1);
%%%%%%% before proceed, the model and shape data must be scale-invariant
%%%%%%% and center-aligned. 
[NNIdx, DD] = knnsearch(Ref', Ref', 'k', 2);
res = 10.0*median(DD(:, 2));
Ref = Ref / res;
Mov = Mov / res;
mDiff = mean(Ref, 2) - mean(Mov, 2);
Mov = bsxfun(@plus, Mov, mDiff);
res = 0.5;
figure;
hold on;
grid on;
axis equal;
if nDim == 3
    pcshow(Ref', 'g');
    pcshow(Mov', 'r');
else
    plot(Ref(1, :), Ref(2, :), 'g.');
    plot(Mov(1, :), Mov(2, :), 'r.');
end

xRange = [min(Ref(1, :)) max(Ref(1, :))];
yRange = [min(Ref(2, :)) max(Ref(2, :))];
if nDim == 3
    zRange = [min(Ref(3, :)) max(Ref(3, :))];
end

if nDim == 3
    x0 = zeros(6, 1); % [gtT - 1.0*norm(gtT)*rand(3, 1); gtAng'-deg2rad(10.0*rand(3, 1))]; % [0.0; 0.0; deg2rad(40.0)];
else
    x0 = [0.0; 0.0; 0.0]; [0; 0; deg2rad(10.0)];  [20; 0; deg2rad(30.0)];
end
[R0, T0] = state2RTFun(x0);
figure;
hold on;
grid on;
axis equal;
plot(Ref(1, :), Ref(2, :), 'g.');
plot(Mov(1, :), Mov(2, :), 'r.');
Aft = Loc2Glo(Mov, R0', T0);
Mov = Aft;
plot(Aft(1, :), Aft(2, :), 'b.');
title('initial condition');
Md = createns(Ref'); 