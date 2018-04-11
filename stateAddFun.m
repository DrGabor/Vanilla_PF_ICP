function [xNew] = stateAddFun(x,dx)
[R0, T0] = state2RTFun(x); 
[dR, dT] = state2RTFun(dx);
R = R0*dR;
T = T0 + dT;
xNew = RT2stateFun(R, T);
end

