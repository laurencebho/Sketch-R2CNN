#!/bin/bash
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --gres=gpu
#SBATCH -p ug-gpu-small
#SBATCH --qos=short
#SBATCH -t 01-00:00:00
#SBATCH --job-name=sketchr2cnnLaurie
#SBATCH --mem=8G
#SBATCH --mail-user laurence.ho@durham.ac.uk
#SBATCH --mail-type=ALL

source ~/sketchr2cnnenv/bin/activate
module load cuda/10.1-cudnn7.6

cd scripts/
python3 quickdraw_r2cnn_get_images.py

CL_MODEL="resnet50"
CL_DATASET="quickdraw"
CL_DATASET_ROOT="../quickdraw"
CL_LOG_DIR="../trained_weights"

CL_CKPT_PREFIX="quickdraw_${CL_MODEL}"
mkdir "${CL_LOG_DIR}/${CL_CKPT_PREFIX}_eval"

    python quickdraw_r2cnn_eval.py \
        --checkpoint "/host${CL_LOG_DIR}/${CL_CKPT_PREFIX}" \
        --dataset_fn ${CL_DATASET} \
        --dataset_root "/host${CL_DATASET_ROOT}" \
        --intensity_channels 8 \
        --log_dir "/host${CL_LOG_DIR}/${CL_CKPT_PREFIX}_get_images" \
        --model_fn ${CL_MODEL} \
    2>&1 | tee -a "${CL_LOG_DIR}/${CL_CKPT_PREFIX}_get_images/get_images.log"
