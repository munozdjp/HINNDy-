<p align="center">

# MATLAB-HINNDy

## Hidden Identification of Nonlinear Normal form Dynamics 

Collection of Matlab implementaion of HINNDY presented in reasearch paper. The implementation mirror the ones proposed in the paper. I have choseen to focus on getting every implementation and specifics right.

* [Workflow](#Hinndy Workflow)  
* [Summary](#Summary)
* [Code](#Code)

# HINNDy workflow

![Figure 1](https://user-images.githubusercontent.com/67231886/216831134-8c8a00b7-ed6d-43b1-974b-f3de3f376b19.png)

# Summary

### HINNDy
Hidden Identification of Nonlinear Normal form Dynamics
Put bullet points instead of abstract. 
#### Authors
Juan Pablo Munoz Diaz,..., David Gomez Cabrero, Narsis Kiani, Jesper tegner

#### Abstract

Here we explore the idea of using normal forms as universal, scalable, and minimal dynamical building blocks to capture and model the system dynamics. Our method, called HINNDy, samples observations in the vicinity of a slow manifold and formulate the problem to a constrained opti- mization problem. We evaluate performance, robustness against noise, and data requirements by benchmarking HINNDy against standard bifurcation models (Saddle-node, Transcritical, Pitchfork, Hopf). Next, we tested HINNDy for the discovery of Lorentz, Van Der Pol, the Hodgkin-Huxley, and Fitzhugh-Nagumo dynamical systems from data generated by these models.

For further details please read the complete publication [Publication](https://github.com/munozdjp/HINNDY/tree/main/HINNDy__Code)

  
# Code
  
MATLAB-2020.

Download the [Folder](https://github.com/munozdjp/HINNDy-/tree/main/HINNDy__Code), and run each script in the specific directory cd/HINNDy__Code/<script>

The scripts generates the results for 
  * Prediction of Learned Variable
  * Noise analysis. 
  
Saddle-node bifurcation:
* [Code SaddleNode](https://github.com/munozdjp/HINNDy-/blob/main/HINNDy__Code/SaddleNodeLeft2Rigth.m)
  
Pithchfork-bifurcation:
* [Code Pitchfork](https://github.com/munozdjp/HINNDy-/blob/main/HINNDy__Code/Hopf_fit_withobservedVariablesNonNormal.m)

Hopf-Bifurcation:
* [Code Hopf](https://github.com/munozdjp/HINNDy-/blob/main/HINNDy__Code/Hopf_fit_withobservedVariablesNonNormal.m)

Hodking-Huxley
* [Code Hodking-Huxley Dynamical model](https://github.com/munozdjp/HINNDy-/blob/main/HINNDy__Code/hodg_Hux_fit_ObservedVariables.m)

Fitzhugh-Nagumo
* [Code Fitzhugh-Nagumo Dynamical Model](https://github.com/munozdjp/HINNDy-/blob/main/HINNDy__Code/Fitz_Nagumo2th_fit_ObservedVariables.m)







