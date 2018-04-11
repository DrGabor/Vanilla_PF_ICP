function  [particles,keep, Neff] = stratified_resample(particles,N)
%function [keep, Neff] = stratified_resample(w)
%
% INPUT:
%   w - set of N weights [w1, w2, ..]
%
% OUTPUTS:
%   keep - N indices of particles to keep 
%   Neff - number of effective particles (measure of weight variance)
%
% Tim Bailey 2004.

% w= [particles.w].*exp(-[particles.Phi]./mean([particles.Phi]));
% w= w / sum(w); % normalise
% parfor i=1:N
%     particles(i).w= w(i);
% end
w = cat(2, particles(:).w); 
Neff= 1 / sum(w .^ 2);
len= length(w);
keep= zeros(1,len);
select = stratified_random(len); 
w= cumsum(w); 
ctr=1; 
for i=1:len
   while ctr<=len & select(ctr)<w(i)
       keep(ctr)= i;
       ctr=ctr+1; 
   end
end
