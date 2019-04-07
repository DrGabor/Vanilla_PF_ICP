# Vanilla_PF_ICP
Iterative closest point via particle filtering. 

This code is basically used for 2D/3D point set registration, and the registration process is modelled as a state estimation problem, which can be solved efficiently via filtering techiniques, like UKF, CKF and particle filter. To understand the theory, the readers are referred to [1][2][3]. Also, it is good to cite these articles if you use this code.

Special thanks goes to Jihua ZHU, who provided me with the code of particle filter; And also thanks goes to Dr. Liang LI, who discussed with me for technique details including motion alignment error and density proposal. 

Please make sure that you also add "LiDAR/CommonFunctions" to your matlab PATH, which provide functions relating to coordinate transformation.

[1]	R. Sandhu, S. Dambreville and A. Tannenbaum, "Point Set Registration via Particle Filtering and Stochastic Dynamics," IEEE Transactions on Pattern Analysis and Machine Intelligence, vol. 32, pp. 1459-1473, 2010.

[2] 祝继华, 杜少毅, 李钟毓,等. 基于粒子滤波的部分对应点集刚体配准算法[J]. 中国科学:信息科学, 2014, 44(7):886-899.

[3]	L. Li, M. Yang, C. Wang, and B. Wang, "Hybrid Filtering Framework based Robust Localization for Industrial Vehicles," IEEE Transactions on Industrial Informatics, vol. PP, p. 1-1, 2018.

If you have any problems, please feel free to contact me.


Di Wang

Laboratory of Visual Cognitive Computing and Intelligent Vehicle

Institute of Artificial Intelligence and Robotics

Xi'an Jiaotong University

Xi'an, Shaanxi, 710049, P.R. China

de2wang@stu.xjtu.edu.cn

280868861@qq.com
