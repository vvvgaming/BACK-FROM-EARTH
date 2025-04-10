import torch, torchvision
import numpy as np
from torch import nn as nn
import torch.nn.functional as F
import argparse
from Dataloader import get_train_valid_loader
import torchvision.utils as vutils
import matplotlib.pyplot as plt
from train_autoencoder import ConvAutoencoder
from train_ffn import CombineLatent

def Adversarail_training(Alice, Roman, Eve, Bob, FFN, train_data_loader, batch_size, FFN_optim, GAN_epoch, Alice_epoch, Roman_epoch, Eve_epoch):

  for j in range(GAN_epoch):
    print("The Adversarial Epoch is:", j)
    FFN.train()


    for k in range(Alice_epoch):
      train_loss_ba = 0
      min_train_loss_ba = 100
      for i, train_data in enumerate(train_data_loader):
        FFN_optim.zero_grad()
        if len(train_dat)