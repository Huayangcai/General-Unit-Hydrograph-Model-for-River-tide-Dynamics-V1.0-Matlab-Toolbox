# General Unit Hydrograph Model for River-tide Dynamics V1.0 Matlab Toolbox


Huayang Cai

Institute of Estuarine and Coastal Research, School of Ocean Engineering and Technology, Sun Yat-sen University, Guangzhou, 510275, China
Correspondence: Huayang Cai (caihy7@mail.sysu.edu.cn)

2024/04/09


A General unit hydrograph model Matlab toolbox for water level and tidal range distributions in the Modaomen Estuary, China.
Version 1.0 - April 2024

Provided by Huayang Cai

Institute of Estuarine and Coastal Research, School of Ocean Engineering and Technology, Sun Yat-sen University

Email contacts: caihy7@mail.sysu.edu.cn

How to cite:

- Bo Li, Huayang Cai, Gaojin Li, Jing Liu, Zhenyan She, Yajun Wang, Suying Ou, Feng Liu, Tongtiegang Zhao, Kairong Lin (2024), A general unit hydrograph theory for water level and tidal range distributions in the Modaomen Estuary, China, Journal of Hydrology, submitted.

How to use General Unit Hydrograph Model for River-tide Dynamics 

1.	Download and install General Unit Hydrograph Model for River-tide Dynamics Matlab toolbox

Users can download the latest General Unit Hydrograph Model for River-tide Dynamics Matlab toolbox from Github:

https://github.com/Huayangcai/General-Unit-Hydrograph-Model-for-River-tide-Dynamics-V1.0-Matlab-Toolbox.git

2.	General Unit Hydrograph Model for River-tide Dynamics Demo

2.1.	Reproducing the water level and tidal range distributions

First of all, you need to load the data provided by General Unit Hydrograph for River-tide Dynamics Matlab Toolbox (such as `Data_Modaomen.mat`). The demo can be executed using the main program labelled by `Example_GUH_Modaomen.m`.

The data file ‘Data_Modaomen.mat’ contains 3 variables, including `stname`, `z` and `h`. 

`stname` denotes the name of gauging stations, including 6 columns (e.g., SZ, DLS, ZY, JM, GZ and MK, respectively). 

For instance:

`SZ`

`DLS`

`JM`

`ZY`

`GZ`

`MK`

`z` and `h` denote monthly water level and tidal range data, respectively. The data between the 1st and the 6th column denote the water level and tidal range series observed in the stations mentioned above. For instance, there are 6 columns of water levels and tidal ranges in this variable, the 1st column represents the data in SZ, while the 6th column represents the data in MK.

The syntax of the main subroutine is illustrated below:


[X,yy,yy_gradient,Xdata2,yy2,yy2_gradient,X1,X2,sigma]=f_GUH_waterlevel_distributions(inputs);

or


[X,yy,yy_gradient,Xdata2,yy2,yy2_gradient,X1,X2,sigma]=f_GUH_tidalrange_distributions(inputs);


Descriptions of the inputs:

`inputs`: contains two columns, the first column is the distance, while the second column is the water level or tidal range at the six stations

Descriptions of the outputs:

`X`: linear regression coefficients for the GUH model, containing xp, mu and m

`yy`: the computed water levels and tidal ranges in the six stations

`yy_gradient`: the computed water level and tidal range gradient in the six stations

`Xdata2`: used for reproducing water level and tidal range distributions along the channel, in this case, the channel length and interval is 150 km and 1 km, respectively

`yy2`: the computed water levels and tidal ranges along the channel axis

`yy2_gradient`: the computed water level and tidal range along the channel axis

`X1`: the first inflection point

`X2`: the second inflection point

`sigma`: the deviation of the two inflection points to the xp
