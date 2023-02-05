clear all, close all, clc
figpath = '../figures/';
addpath('./utils');
addpath('./NoiseFunctions/');
addpath('./plottingfunctions/');

% %coefficient of the right polinomial (polinomial of order 4 ...
% %that perform the desired behavior (increasing))
%  
% % p1 =         1.1; 
% % p2 =      0.9285;
% % p3 =    -0.02771;
% % p4 =   0.0003581;
% % p1 =         5;
% % p2 =      0;
% % p3 =    0;
% % p4 =   0;
% p1 =         1.1; 
% p2 =      0.09285;
% p3 =    0;
% p4 =   0;
% 
% epsilon=14;
% a= 0.06;
% lambda=0.5;
% n = 4; % Number of variables
% dt=0.0001; % Timestep
% 
% % Integrate Interval of time. 
% %(How to create interval of time given ...
% %...interval of beta parameteer)
% Initinterval = 250;
% neg_inter = 0;
% tinterval=[neg_inter Initinterval];
% tspan=[.001:dt:tinterval(2)-tinterval(1)];
% N = length(tspan);
% options = odeset('RelTol',1e-12,'AbsTol',1e-12*ones(1,n));
% X=[];
% 
% %Coeficients of polyorder 3; p1+p2*t+p3*t^2+p4*t^3 & and initial time value 
% c=[p1,p2,p3,p4,Initinterval];
% yzero=c(1)+c(2)*(tspan)+c(3)*(tspan).^2+c(4)*(tspan).^3;
% 
% %Plot of inverted polynomial
% figure(1)
% plot(tspan,yzero,'r-')
% xlabel('time')
% ylabel('beta parameter')
% hold on
% xline(0,'k--');
% set(gca,'FontSize',16);
% l=legend('Explicit polinomial for steady state generation');
% l.FontSize = 14;
% l.Location='northeast';
% title('Inverted polinomial');
% hold off
% 
% traslation=0; %traslation of the system in y coordinate
% %% integration of the lorentz system
% %     i=i+1
% for mu0=[c(1)]; %initial condition of Beta
%     for u0 = 0.048498469; %Iniitial contions for x and y [x0,x0,z0]        
%         w0 = 0.80830782; %initial condition for z0
%         %[t,x] = ode45(@(t,x) Fitz_Nagumo2th(t,x,c,a,lambda,epsilon),tspan,[tspan(1),mu0,u0,w0],options);
%         [t,x] = ode23s(@(t,x) Fitz_Nagumo2th(t,x,c,a,lambda,epsilon),tspan,[tspan(1),mu0,u0,w0],options);
%          X = [X;x];
%             % Plot of state variable vs Beta parameter
%             figure(2)
%             hold on
%             plot(x(:,2),x(:,3),'b-')
%             xlabel('Beta')
%             ylabel('x_3')
%             xline(0,'k--');
%             set(gca,'FontSize',16);
%             l=legend('Trajectory using numerical integration');
%             l.FontSize = 14;
%             l.Location='northeast';
%             title('State variable vs Biffurcation parameter')
%             hold off    
%     end
% end
%save('variablesFitzHug')
%% 
load('variablesFitzHug.mat')

    %Mu observed from equations of steady state
    %normalization: 
xMax = max(abs(x));
[x,yzero] = xNormalization(x,yzero);

mufunc = @(x) (x(:,4)*xMax(4))-epsilon*((x(:,3)*xMax(3)).*((x(:,3)*xMax(3))-lambda).*(1-(x(:,3)*xMax(3))));
mu_observed=mufunc(x);

%Be carefull with function F1, I can not copy that one. 
%Be carefull the the initial amount of weights.
%Be carefull with the initial vector of different scales. 


            
%%Polinomial fit
%Define the function to fi: "Poly order 2"
F1=@(weightdx,time) weightdx(1)+weightdx(2)*time+time.^2*weightdx(3)+...
    time.^3*weightdx(4);
%Curve fitting
weights0=[0.5 0.5 0.5 0.5];
opts = optimoptions('lsqcurvefit','Display','off');
[weightdx, resnorm,~,exitflag,output] = lsqcurvefit(F1,weights0, tspan, mu_observed',[],[],opts);

%Data predicted from F1 evaluated in the polinomail fit
reproduced_data= F1(weightdx,tspan);

plotState_Beta_time_Pred(tspan,x,mu_observed,yzero,reproduced_data,n,3)


%plot of beta from: real VS numerical integration

%% Mu with Noise experimental single noise
noise_scale=0.5;   

[xNoisy, Noise_normalized] = add_Noise_Max(x,noise_scale);

%next step is to use the noise for the figures. 
mu_obsNoisy = mufunc(xNoisy);
opts = optimoptions('lsqcurvefit','Display','off');
[weightdxNoise,resnormNoise,~,exitflagNoise,outputNoise] = lsqcurvefit(F1,weights0, tspan, mu_obsNoisy',[],[],opts);

reproduced_dataNoisy= F1(weightdxNoise,tspan);

comparisonVector = [c(1:(length(c)-1));weightdx;weightdxNoise]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 
% plotCleanNoiseStateFig_5(tspan,Noise_normalized,yzero,n)


%% Noise analysis 
% Creation of comparison vector for different noise variances: 
VectorOfNoise = [0:0.1:.5];
name = mfilename;
name = name(1:10);
%noise_Scale_maximum(F1,weights0, tspan, x,c,yzero,VectorOfNoise,name,mufunc)
noise_5_Boxplots(F1,weights0, tspan, x,c,yzero,VectorOfNoise,name,mufunc)
