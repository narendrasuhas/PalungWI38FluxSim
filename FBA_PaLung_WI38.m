%{ 
Copyright (C) 2023  N. Suhas Jagannathan
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
%}

% This script is used to run flux sampling simulations for the bat PaLung
% and human WI38 mitochondrial metabolic models using COBRA toolbox v3.0

%% Initialize models and simulation parameters 

options.nStepsPerPoint = 200;
options.nPointsReturned = 5000; % Generate these many samples (flux vectors) for flux sampling
options.optPercentage = 0;

load MetModels.mat % Loads the metabolic network files b_model (PaLung) and h_model (WI-38)
b_model = changeObjective(b_model,'CV_MitoCore');
h_model = changeObjective(h_model,'CV_MitoCore');

%% Control flux sampling simulations (no constraints)

[~, sample_bat_ctrl] = sampleCbModel(b_model,'sample_bat_ctrl.mat','CHRR',options);
[~, sample_human_ctrl] = sampleCbModel(h_model,'sample_human_ctrl.mat','CHRR',options);

%% Set constraints on Complex I and Oxygen intake into mitochondria in both models.

minFrac = 0.2;
maxFrac = 1-minFrac;

% Constrain Complex I of b_model to be at the higher end of its flux range
[b_minC1, b_maxC1] = fluxVariability(b_model,0,'max',{'CI_MitoCore'});
b_C1_maxFrac = b_minC1 + (b_maxC1-b_minC1)*maxFrac;
b_model = changeRxnBounds(b_model,'CI_MitoCore',b_C1_maxFrac,'l');

% Constrain Complex I of h_model to be at the lower end of its flux range
[h_minC1, h_maxC1] = fluxVariability(h_model,0,'max',{'CI_MitoCore'});
h_C1_minFrac = h_minC1 + (h_maxC1-h_minC1)*minFrac; 
h_model = changeRxnBounds(h_model,'CI_MitoCore',h_C1_minFrac,'u'); 

% Constrain O2 of b_model to be at the lower end of its flux range
[b_minO2, b_maxO2] = fluxVariability(b_model,0,'max',{'O2tm'});
b_O2_minFrac = b_minO2 + (b_maxO2-b_minO2)*minFrac; 
b_model = changeRxnBounds(b_model,'O2tm',b_O2_minFrac,'u'); 

% Constrain O2 of h_model to be at the higher end of its flux range (and
% higher than the b_model O2 flux range)
[h_minO2, h_maxO2] = fluxVariability(h_model,0,'max',{'O2tm'});
h_O2_maxFrac = h_minO2 + (h_maxO2-h_minO2)*maxFrac;  
h_O2_maxFrac = max(h_O2_maxFrac,b_O2_minFrac);
h_model = changeRxnBounds(h_model,'O2tm',h_O2_maxFrac,'l'); 

%% Flux sampling simulations with constraints

[~, sample_bat_constr] = sampleCbModel(b_model,'sample_bat_constr.mat','CHRR',options);
[~, sample_human_constr] = sampleCbModel(h_model,'sample_human_constr.mat','CHRR',options);
