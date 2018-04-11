function [R, T] = icpUpdate(Md, Ref, Mov, Tf0, DistThr, L, IS_SHOW)
if nargin == 0
    clc; close all;
    A = pcread('teapot.ply');  %pcread('E:\Dataset\Point Cloud\ply\Bunny\reconstruction\bun_zipper.ply');
    A = pcdownsample(A, 'gridAverage', 0.10 );
    Mov = double(A.Location');
    R0 = eul2rotm( deg2rad([20.0 10.0 10.0]) );
    T0 = [5 5 10.00 ]';
    Ref = Loc2Glo( Mov, R0', T0 );
    Sigma = 0.01;
    rng(100);
    Mov = Mov + Sigma * randn(3,  size(Mov, 2) );
    [Norm_Ref] = CalNormalsFun(Ref, 20, zeros(3, 1) );
    [Norm_Mov] = CalNormalsFun(Mov, 20, zeros(3, 1) );
    Md = createns(Ref');
    Tf0 = [ eye(3) mean(Ref-Mov, 2); 0 0 0 1];
    DistThr = Inf;
    [NNIdx, DD] = knnsearch( Ref', Ref', 'k', 2);
    Res = mean(DD(:, 2));
    DistThr = Inf;
    IS_SHOW = 1; 
    L = 5; 
end
bVerbose = false; % true;
MaxIter = L;
Dim = size(Ref, 1);
R = Tf0(1:Dim, 1:Dim);
T = Tf0(1:Dim, end);
for Iter = 1 : 1 : MaxIter
    % Iter
    %%%%%%%%%%% establish correspondence.
    AftData = Loc2Glo( Mov, R', T );
    [NNIdx, DD] = knnsearch( Md, AftData' );
    idx = find(DD' < DistThr);
    tmpDist = 1.0*DistThr;
    while length(idx) < 10
        tmpDist = tmpDist + 0.5*DistThr;
        idx = find(DD' < tmpDist);
    end
    MovIdx = idx;
    RefIdx = NNIdx(idx);
    %%%%%%%%%%% obtain rotation and translation via SVD.
    [ dR, dT ] = RegFun(Ref(:, RefIdx), AftData(:, MovIdx) );
    R = dR * R;
    T = dR * T + dT;
    %%%%%%%%%%% check convergence condition.
    Err = max( norm(dR - eye(Dim)), norm(dT) );  % CalRT_Diff(TotalTf(end).Tf, TotalTf(end-1).Tf );
    %     str = sprintf( 'Iter = %02d, Err = %f\n', Iter, Err );
    %     disp(str);
    if Err(1) <= 1e-6
        break;
    end
end
if nargout == 1
    varargout{1} = [R T];
end
if nargout == 2
    varargout{1} = R;
    varargout{2} = T;
end
if IS_SHOW
    figure;
    hold on;
    view(3);
    showPointCloud(Ref', 'g');
    showPointCloud(Mov', 'r');
    AftData = Loc2Glo( Mov, R', T );
    showPointCloud(AftData', 'b');
    
    if nargin == 0
        ErrR = RotationDiff( R, R0 );
        ErrT = norm(T - T0 );
        title(sprintf( 'Point-to-Point ICP, ErrR = %.4fdegs ErrT = %.4f', rad2deg(ErrR), ErrT ));
    else
        title('Point-to-Point ICP');
    end
end

