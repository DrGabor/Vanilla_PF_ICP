%%%%%%%%%% update particle weight.
W = [];
for id = 1 : 1 : length(particles)
    para = particles(id).xv;
    [R, T] = state2RTFun(para);
    Aft = Loc2Glo(Mov, R', T);
    [NNIdx, DD] = knnsearch(Md, Aft');
    %%%%% p <= 1.0 will make the object function more robust to noise
    %%%%% and outliers.
    p = 0.5;
    W(end+1) = -sum(DD.^p); % -sum(DD.^2); % L1 norm?
end
if isrow(W)
    W = W';
end
W = W - max(W);
W = exp(W);
% WOld = cat(1, particles(:).w);
% W = W .* WOld;
W = W / sum(W);
for id = 1 : 1 : length(particles)
    particles(id).w = W(id);
end

% Pos = cat(2, particles(:).xv);
% figure;
% hold on;
% grid on;
% axis equal;
% plot(Pos(1, :), Pos(2, :), 'b.');
