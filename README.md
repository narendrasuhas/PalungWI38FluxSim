# PalungWI38FluxSim

This repository includes MATLAB scripts (and associated data file) that were used to perform flux sampling and histogram plotting ,for the work comparing WI-38 and PaLung metabolism from the labs of Prof. Lisa Tucker-Kellogg and Prof. Koji Itahana at Duke-NUS Medical School, Singapore.

## Requirements

The scripts were written in and executed using Matlab, and have been verified to work with MATLAB versions 2019b and 2023a.
To run the flux sampling script, the user will first need to install the COBRA toolbox v3.0 and the Gurobi optimizer.

### Installing COBRA toolbox 
COBRA toolbox provides most of the core functionality for performing constraint-based analysis of metabolic flux networks.
Information on how to install the toolbox can be found at https://opencobra.github.io/cobratoolbox/stable/installation.html

### Installing the Gurobi optimizer
The toolbox also requires an associated optimizer, for which we used the Gurobi optimizer v9.1.1 with an academic license.
More information about installing Gurobi and obtaining an academic license can be found at https://www.gurobi.com/solutions/gurobi-optimizer/

## Files included
The repository includes two MATLAB scripts and one MATLAB data file.

#### Script files
1) **FBA_PaLung_WI38.m** - This script can be used for loading in the PaLung and WI-38 metabolic networks, adding the relevant constraints to the models, and performing unconstrained and constrained flux sampling. The constraint threshold can be set to different ratios (as explained in the manuscript main text) using the minFrac variable. Figures in the manuscript were generated using a minFrac value of 0.3, which corresponds to constraining downregulated reactions to the lower 30% of their feasible flux range, and constraining upregulated reactions to the upper 30% of their feasible flux range.
   
2) **plot_histogram.m** - Once FBA_PaLung_WI38.m has been run, this script can be run to plot histograms for the following reactions - Complex I, Mitochondrial O2 transport, Complex II and Complex III.

### Data file
1) **MetModels.mat** - This data file contains the PaLung and WI-38 metabolic flux models in a .mat format. This data file needs to be in the same folder as the FBA_PaLung_WI38.m, and is automatically loaded into the MATLAB workspace when running the script.
   
