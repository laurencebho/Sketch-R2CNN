#!/bin/bash
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --gres=gpu
#SBATCH -p ug-gpu-small
#SBATCH --qos=short
#SBATCH -t 01-00:00:00
#SBATCH --job-name=sketr2cnnLaurie
#SBATCH --mem=4G
#SBATCH --mail-user laurence.ho@durham.ac.uk
#SBATCH --mail-type=ALL

source ~/pix2pixenv/bin/activate
module load cuda/9.0-cudnn7.1

python quickdraw_r2cnn_get_images.py
