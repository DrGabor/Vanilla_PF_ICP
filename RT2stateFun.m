function [para] = RT2stateFun(R,T)
para = T; 
if length(T) == 2
    R = [R zeros(2, 1); 0 0 1]; 
    Ang = rotm2eul(R);
    Ang = Ang(1); 
end
if length(T) == 3
    Ang = rotm2eul(R)'; 
end
para = [para; Ang];
end

