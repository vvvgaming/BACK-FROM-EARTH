import torch , torchvision
import numpy as np
from torch import nn as nn 
import torch.nn.functional as F
import argparse
from Dataloader import get_train_valid_loader
import torchvision.utils as vutils
import matplotlib.pyplot as plt
from train_autoencoder import ConvAutoencoder


class CombineLatent(nn.Module):
  def __init__(self,innode):
    super(CombineLatent,self).__init__()
    self.innode = innode
    self.Encoder = nn.Linear(2*innode,innode)
    self.Decoder = nn.Linear(2*innode,innode)
    
  def Encode_Decode(self,image_vec,key_vec):
    inp_vec = torch.cat((image_vec,key_vec),dim=1)
    cipher_vec = self.Encoder(inp_vec)
    binp_vec = torch.cat((cipher_vec,key_vec),dim=1)
    oup_vec = self.Decoder(binp_vec)
    return oup_vec
  
  def ret_Cipher(self,image_vec,key_vec):
    inp_vec = torch.cat((image_vec,key_vec),dim=1)
    cipher_vec = self.Encoder(inp_vec)
    return cipher_vec

def train_CyptoGAN_latent(Alice, Bob , FFN , train_data_loader , valid_data_loader , batch_size , c_optim , n_epoch , FFN_checkpt):
  min_train_loss = 100
  for j in range(n_epoch):
    print("The Epoch is:",j)
    Alice.train()
    Bob.train()
    train_loss = 0
    for i,train_data in enumerate(train_data_loader):
      c_optim.zero_grad()
      if len(train_data[0])!=batch_size :
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
      oup_vec = FFN.Encode_Decode(Alice_vec,Key_vec)
      oup_vec = oup_vec.reshape(-1,x,y,z)
      B_image = Bob.distract_latent(oup_vec)
      criterion = nn.MSELoss()
      loss = criterion(image,B_image)
      if i%100 == 0:
        print(loss)
      loss.backward()
      c_optim.step()
      train_loss += loss.item()      
  
    print("The Training Loss is :" , train_loss / len(train_data_loader))
    if (train_loss / len(train_data_loader)) < min_train_loss : 
      print("Avinash")
      min_train_loss = train_loss / len(train_data_loader)
      torch.save(FFN.state_dict(),FFN_checkpt)

    
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('-batch_size', type=int , default = 32 , help='Training batch size')
    parser.add_argument('-lr', type=float , default = 0.001 , help='an integer for the accumulator')  
    parser.add_argument('-n_epochs' , type=int , default=5)
    parser.add_argument('-dataset_path',type=str , default = "Dataset/101_ObjectCategories")
    parser.add_argument('-convencoder_path',type=str , default = "ConvAutoEncoder.pth")
    parser.add_argument('-deep_FFN_path',type=str , default = "FFN.pth")
    args = parser.parse_args()
    Alice , Bob = ConvAutoencoder() , ConvAutoencoder()
    Alice.load_state_dict(torch.load(args.convencoder_path))
    Bob.load_state_dict(torch.load(args.convencoder_path))
    FFN = CombineLatent(256)   
    c_optim = torch.optim.Adam(FFN.parameters(),lr = args.lr)
    train_loader , valid_loader = get_train_valid_loader(args.dataset_path,args.batch_size,True,1234)    
    train_CyptoGAN_latent(Alice, Bob, FFN, train_loader , valid_loader , args.batch_size , c_optim , args.n_epochs , args.deep_FFN_path)
    