#!/bin/bash
#SBATCH --account=def-rsadve
#SBATCH --mail-user=<a.hebb@mail.utoronto.ca>
#SBATCH --mail-type=ALL

#SBATCH --nodes 1
#SBATCH --tasks-per-node=1 
#SBATCH --cpus-per-task=1 # change this parameter to 2,4,6,... to see the effect on performance

#SBATCH --mem=8G      
#SBATCH --time=00:05:00
#SBATCH --output=%N-%j.out

module purge
module load python/3.11 

virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install -r requirements.txt

echo "starting training..."

# Run baseline crafter
python dreamerv3/train.py --logdir ~/logdir/crafter-dv3_1 \
--env.crafter.outdir ~/logdir/crafter-dv3_1 --configs crafter

# Run tensorboard
tensorboard --logdir ~/logdir/crafter-dv3-cr_1 

