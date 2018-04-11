DataDir = 'bun045.ply';  
cloud = pcread(DataDir); 
cloud = pcdownsample(cloud, 'random', 0.10); 
Ref = cloud.Location'; 
DataDir = 'bun090.ply'; 
cloud = pcread(DataDir); 
cloud = pcdownsample(cloud, 'random', 0.10); 
Mov = cloud.Location'; 