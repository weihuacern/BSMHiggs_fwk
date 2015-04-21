#!/bin/bash

#DIR=~/www/13TeV_topsel_fix/
DIR=~/www/13TeV_topsel_fix_ala8/
mkdir -p ${DIR}
rm -rf ${DIR}*
cp ~/www/HIG-13-026/index.php ${DIR}

#JSONFILEDILEPTON=$CMSSW_BASE/src/UserCode/llvv_fwk/data/chhiggs/phys14_plot_dileptons.json
#JSONFILELEPTAU=$CMSSW_BASE/src/UserCode/llvv_fwk/data/chhiggs/phys14_plot_leptontau.json

# test JSONFILEDILEPTON=$CMSSW_BASE/src/UserCode/llvv_fwk/data/chhiggs/phys14_test.json
# test JSONFILELEPTAU=$CMSSW_BASE/src/UserCode/llvv_fwk/data/chhiggs/phys14_test.json
# test INDIR=$CMSSW_BASE/src/UserCode/llvv_fwk/test/chhiggs/results_ttbar3/
# test ONLYDILEPTON="--only ee_eventflow --only emu_eventflow --only mumu_eventflow"
# test ONLYLEPTAU="--only singlee_eventflow --only singlemu_eventflow"
JSONFILEDILEPTON=$CMSSW_BASE/src/UserCode/llvv_fwk/data/chhiggs/phys14_samples.json
JSONFILELEPTAU=$CMSSW_BASE/src/UserCode/llvv_fwk/data/chhiggs/phys14_samples.json
INDIR=$CMSSW_BASE/src/UserCode/llvv_fwk/test/chhiggs/results_ttbar4/
ONLYDILEPTON=""
ONLYLEPTAU=""

#runPlotterFWLite --iEcm 13 --iLumi 19700 --inDir $CMSSW_BASE/src/UserCode/llvv_fwk/test/chhiggs/results/ --outDir ${DIR} --outFile ${DIR}plotter.root  --json $CMSSW_BASE/src/UserCode/llvv_fwk/data/chhiggs/phys14_plot.json --no2D --noPowers --plotExt .png --plotExt .pdf --only eventflow
#runPlotterFWLite --iEcm 13 --iLumi 19700 --inDir $CMSSW_BASE/src/UserCode/llvv_fwk/test/chhiggs/results/ --outDir ${DIR} --outFile ${DIR}plotter.root  --json $CMSSW_BASE/src/UserCode/llvv_fwk/data/chhiggs/phys14_plot.json --no2D --noPowers --plotExt .png --plotExt .pdf

# Dilepton
runFixedPlotter --iEcm 13 --iLumi 5822 --inDir ${INDIR} --outDir ${DIR} --outFile ${DIR}plotter.root  --json ${JSONFILEDILEPTON} --cutflow all_initNorm --forceMerge --no2D --noPowers --plotExt .png --generatePseudoData ${ONLYDILEPTON}

# Leptontau
runFixedPlotter --iEcm 13 --iLumi 5822 --inDir ${INDIR} --outDir ${DIR} --outFile ${DIR}plotter.root  --json ${JSONFILELEPTAU} --cutflow all_initNorm --forceMerge --no2D --noPowers --plotExt .png --generatePseudoData ${ONLYLEPTAU}


# Lessen the burden on the web browser

for CHAN in emu ee mumu singlemu singlee
do
    mkdir ${DIR}temp${CHAN}/
    mv ${DIR}${CHAN}* ${DIR}temp${CHAN}/
    mv ${DIR}temp${CHAN}/ ${DIR}${CHAN}/
    cp ~/www/HIG-13-026/index.php ${DIR}${CHAN}/
done