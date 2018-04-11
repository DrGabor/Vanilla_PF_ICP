W = cat(1, particles(:).w);
[~, maxId] = max(W);
xOpt = particles(maxId).xv;
tmp = [];
tmp.data = particles;
TParticles = [TParticles tmp];
TPara(:, end+1) = xOpt;