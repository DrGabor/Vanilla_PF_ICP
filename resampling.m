%%%%%%% resampling with replacement.
NPARTICLES = length(particles);
[particles, keep, Neff] = stratified_resample(particles, NPARTICLES);
NEFFECTIVE = NPARTICLES * 0.5; % 0.5;
particles = resample_particles(particles, keep, NPARTICLES);
% figure; plot(W, 'b.-');
if (Neff > NEFFECTIVE)
end