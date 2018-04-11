function particles= resample_particles(particles, keep, N)
%function particles = resample_particles(particles, Nmin, doresample)
%
% Resample particles if their weight variance is such that N-effective
% is less than Nmin.
%
particles = particles(keep);
pre= 0;
for i= 1:N
    if(keep(i)>pre)
        particles(i).id = 0;
    else
        particles(i).id = 1;
    end
    pre = keep(i);
    particles(i).w = 1/N;
end


