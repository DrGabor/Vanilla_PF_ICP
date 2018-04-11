%%%% if it is first time, perform ICP directly, otherwise draw particles
%%%% from proposal density.
if isfield(particles(1), 'S')
    %%%%%%% draw particles.
    Tmp = cat(2, particles(:).xv);
    Mu = Tmp';  % mean
    W = cat(1, particles(:).w); % ones(1, length(particles)) / length(particles); % weight
    Sigma = [];
    Gama = 1.0;
    for id = 1 : 1 : length(particles)
        tmp = Gama * particles(id).S; 
        if isempty(Sigma)
            Sigma = tmp; 
        else
            Sigma(:, :, end+1) = tmp;
        end
    end
    gm = gmdistribution(Mu,Sigma,W);   % mixture of Gaussians.
    ParaNew = random(gm, length(particles));
    for id = 1 : 1 : length(particles)
        particles(id).xv = ParaNew(id, :)';
    end
else
    %%%% initial particles with a uniform distribution
    aRange = [-pi pi]; 
    for id = 1 : 1 : length(particles)
        para = [];
        para(end+1) = xRange(1) + ( xRange(2)-xRange(1) ) * rand(1);
        para(end+1) = yRange(1) + ( yRange(2)-yRange(1) ) * rand(1);
        if nDim == 3
            para(end+1) = zRange(1) + ( zRange(2)-zRange(1) ) * rand(1);
        end
        if isrow(para)
            para = para';
        end
        if nDim == 3
            tmp = aRange(1) + (aRange(2)-aRange(1))*rand(3,1); 
            para = [para; tmp];   % Euler angle range is [-pi pi].
        else
            para(end+1) = aRange(1) + (aRange(2)-aRange(1))*rand(1);
        end
        particles(id).xv = para;
    end
end
%%%%% perform ICP.
for id = 1 : 1 : length(particles)
    para0 = particles(id).xv;
    [R0, T0] = state2RTFun(para0);
    %%%%%% perform L steps of icp.Standard point-to-point ICP is engough
    %%%%%% for a good PF ICP. 
    [R, T] = icpUpdate(Md, Ref, Mov, [R0, T0], 5.0*res, L, 0);
    paraNew = RT2stateFun(R, T);
    e = para0 - paraNew;
    if nDim == 3
        e(4:6) = wrapToPi(e(4:6)); 
    else
        e(3) = wrapToPi(e(3)); 
    end
    S = e*e';  
    %%%% remove the correlations between different component, 
    %%%% a little different with Sandhu, but works quite well.
    S = diag(diag(S));  
    particles(id).S  = S;
    particles(id).xv = paraNew;
end