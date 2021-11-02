import torch , torchvision
import numpy as np
from torch import nn as nn 
import torch.nn.functional as F
import argparse
from Dataloader import get_train_valid_loader
import torchvision.utils as vutils
import matplotlib.pyplot as plt
from train_autoencoder import ConvAutoencoder
from train_ffn import CombineLatent
def train_Eve(Alice, FFN, Eve, train_data_loader, valid_data_loader,batch_size, e_optim, n_epochs):
  min_train_loss = 100
  for j in range(n_epochs):
    print("The Epoch is:",j)
    Alice.train()
    Bob.train()
    train_loss = 0
    for i,train_data in enumerate(train_data_loader):
      e_optim.zero_grad()

      if len(train_data[0])!=batch_size :
            print(len(train_data[0]))        
            continue      
      arr = np.arange(batch_size)
      np.random.shuffle(arr) 
      image = train_data[0]
      keys = train_data[0][arr]
      Alice_vec = Alice.extract_latent(image)
      Key_vec = Alice.extract_latent(keys)
      _,x,y,z = Alice_vec.size()
      Alice_vec = Alice_vec.reshape(batch_size,-1)
      Key_vec = Key_vec.reshape(batch_size,-1)
      oup_vec = FFN.ret_Cipher(Alice_vec,Key_vec)
      oup_vec = oup_vec.reshape(-1,x,y,z)
      E_image = Eve.distract_latent(oup_vec)
      criterion = nn.MSELoss()
      loss = criterion(image,E_image)
      if i%50 == 0:
        print(loss)
      loss.backward()
      e_optim.step()
      train_loss += loss.item()      
  
    print("The Training Loss is :" , train_loss / len(train_data_loader))
    if (train_loss / len(train_data_loader)) < min_train_loss : 
      print("Avinash")
      min_train_loss = train_loss / len(train_data_loader)
      torch.save(Eve.state_dict(),"Eve.pth")
      
      
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('-batch_size', type=int , default = 32 , help='Training batch size')
    parser.add_argument('-lr', type=float , default = 0.001 , help='learning rate')  
    parser.add_argument('-n_epochs' , type=int , default=5)
    parser.add_argument('-dataset_path',type=str , default = "Dataset/101_ObjectCategories")
    parser.add_argument('-convencoder_path',type=str , default = "ConvAutoEncoder.pth")
    parser.add_argument('-deep_FFN_path',type=str , default = "FFN.pth")
    parser.add_argument('-Eve_checkpt',type=str,default = "Eve.pth")
    args = parser.parse_args()
    Alice , Bob , Eve = ConvAutoencoder() , ConvAutoencoder() , ConvAutoencoder() 
    Alice.load_state_dict(torch.load(args.convencoder_path))
    Bob.load_state_dict(torch.load(args.convencoder_path))
    FFN = CombineLatent(256)   
    FFN.load_state_dict(torch.load(args.deep_FFN_path))
    c_optim = torch.optim.Adam(Eve.parameters(),lr = args.lr)
    train_loader , valid_loader = get_train_valid_loader(args.dataset_path,args.batch_size,True,1234)    
    train_Eve(Alice, Bob, FFN, train_loader , valid_loader , args.batch_size , c_optim , args.n_epochs , args.Eve_checkpt )
    