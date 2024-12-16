#!/bin/bash

set -euo pipefail

start_time=$(date +%s)

## Env Setup for LambdaLabs

# Lambdastack Already installed
# GPU software: CUDA, cuDNN, nvidia drivers
# DL Frameworks: PyTorch, TensorFlow
# Dev tools: Git, Vim, Emacs, Valgrind, tmux, screen,
# htop, build-essential 

# Install OhMyBash
echo "Installing OhMyBash"
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
echo "Done."

echo "Creating .vimrc"
CONFIG="syntax on
set t_Co=256
colorscheme desert"
echo "$CONFIG" >> $HOME/.vimrc
echo "Done."

# Install Eternal Terminal
echo "Installing Eternal Terminal"
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:jgmath2000/et
sudo apt-get update -y
sudo apt-get install et -y
systemctl --no-pager status et
echo "Done."

# Installing Python Deps
echo "Installing Python Deps"
pip install transformers mypy tiktoken

python -c 'import torch ; print("\nIs available: ", torch.cuda.is_available()) ; \
 print("Pytorch CUDA Compiled version: ", torch._C._cuda_getCompiledVersion()) ; \
  print("Pytorch version: ", torch.__version__) ; print("pytorch file: ", torch.__file__) \
  ; num_of_gpus = torch.cuda.device_count(); print("Number of GPUs: ",num_of_gpus)'
echo "Done."

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo "Completed Setup. Elapsed time: $elapsed_time seconds"

# Conda if needed
# sudo chown -R $USER /opt/miniconda # it is root owned in the start
# export PATH="/opt/miniconda/bin:$PATH"
# echo "export PATH=\"/opt/miniconda/bin:$PATH\"" >> $HOME/.bashrc
# conda config --set auto_activate_base false
# conda install -c pytorch -c nvidia pytorch torchvision torchaudio pytorch-cuda=12.4 jupyter matplotlib transformers mypy -y