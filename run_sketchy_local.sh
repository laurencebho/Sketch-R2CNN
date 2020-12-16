#!/bin/bash

cd scripts/
export CUDA_HOME=~
export CUDA_VISIBLE_DEVICES=""
echo $CUDA_HOME
CL_MODEL="resnet50"
#CL_MODEL="sketchanet"

CL_DATASET="sketchy"
CL_DATASET_ROOT="../sketchy_small.pkl"
CL_LOG_DIR="../trained_weights"

CL_CKPT_PREFIX="sketchy_${CL_MODEL}"
mkdir "${CL_LOG_DIR}/${CL_CKPT_PREFIX}_get_images"


python3 -u sketchy_get_images.py \
    --checkpoint "${CL_LOG_DIR}/${CL_CKPT_PREFIX}_fold{}" \
    --dataset_fn ${CL_DATASET} \
    --dataset_root "${CL_DATASET_ROOT}" \
    --intensity_channels 8 \
    --log_dir "${CL_LOG_DIR}/${CL_CKPT_PREFIX}_get_images" \
    --model_fn ${CL_MODEL} \
    --gpu 0 \
2>&1 | tee -a "${CL_LOG_DIR}/${CL_CKPT_PREFIX}_get_images/get_images.log"
echo $CUDA_HOME