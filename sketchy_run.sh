#!/bin/bash
#SBATCH -N 1
#SBATCH -c 1
#SBATCH --gres=gpu
#SBATCH -p ug-gpu-small
#SBATCH --qos=short
#SBATCH -t 02-00:00:00
#SBATCH --job-name=sketchr2cnnLaurie
#SBATCH --mem=16G
#SBATCH --mail-user laurence.ho@durham.ac.uk
#SBATCH --mail-type=ALL

source ~/sketchr2cnnenv/bin/activate
module load cuda/10.1-cudnn7.6

cd scripts/

CL_MODEL="resnet50"
#CL_MODEL="sketchanet"

CL_DATASET="sketchy"
CL_DATASET_ROOT="../sketchy_small.pkl"
CL_LOG_DIR="../trained_weights"

CL_CKPT_PREFIX="sketchy_${CL_MODEL}"
mkdir "${CL_LOG_DIR}/${CL_CKPT_PREFIX}_eval"

sudo nvidia-docker run --rm \
    --network=host \
    --shm-size 8G \
    -v /:/host \
    -v /tmp/torch_extensions:/tmp/torch_extensions \
    -v /tmp/torch_models:/root/.torch \
    -w "/host$PWD" \
    -e PYTHONUNBUFFERED=x \
    -e CUDA_CACHE_PATH=/host/tmp/cuda-cache \
    craigleili/sketch-r2cnn:latest \
    python sketchy_get_images.py \
        --checkpoint "${CL_LOG_DIR}/${CL_CKPT_PREFIX}_fold{}" \
        --dataset_fn ${CL_DATASET} \
        --dataset_root "${CL_DATASET_ROOT}" \
        --intensity_channels 8 \
        --log_dir "${CL_LOG_DIR}/${CL_CKPT_PREFIX}_get_images" \
        --model_fn ${CL_MODEL} \
    2>&1 | tee -a "${CL_LOG_DIR}/${CL_CKPT_PREFIX}_get_images/get_images.log"