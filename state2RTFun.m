function [R, T] = state2RTFun(para)
if length(para) == 3
    T = para(1:2);
    Ang = para(3);
    R = [cos(Ang) -sin(Ang)
        sin(Ang)  cos(Ang) ];
end
if length(para) == 6
    T = para(1:3);
    R = eul2rotm(para(4:end)');
end
end

