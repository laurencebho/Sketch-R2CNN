wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh -O ~/miniconda.sh && \
  /bin/bash ~/miniconda.sh -b -p ~/conda && \
  rm ~/miniconda.sh


pip install --upgrade pip
pip install --upgrade --ignore-installed setuptools
pip install numpy scipy scikit-image matplotlib pytz PyYAML Pillow tqdm protobuf ninja lmdb addict fire rdp opencv-python typing mpi4py
pip install torch==1.0.1.post2 torchvision==0.2.2.post3 pytorch-ignite==0.2.0 tensorboardX==1.7
pip install git+https://github.com/rbgirshick/yacs
pip install git+https://github.com/Cadene/pretrained-models.pytorch
