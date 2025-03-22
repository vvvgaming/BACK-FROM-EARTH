# import torch , torchvision
# import numpy as np
# from torch import nn as nn
# import torch.nn.functional as F
# import argparse
# from Dataloader import get_train_valid_loader
import torchvision.utils as vutils
import matplotlib.pyplot as plt
from train_autoencoder import ConvAutoencoder
from train_ffn import CombineLatent

def Adversarial_training(Alice, Eve, Bob, FFN, train_data_loader, batch_size, FFN_optim, Eve_optim, GAN_epoch, Alice_epoch, Eve_epoch):

	for j in range(GAN_epoch):
		print("The Adversarial Epoch is:", j)
		FFN.train()

		for k in range(Alice_epoch):
		  train_loss_ba = 0
		  min_train_loss_ba = 100
		  for i, train_data in enumerate(train_data_loader):
		  	FFN_optim.zero_grad()
		  	if len(train_data[0]) != batch_size :
		  		continue
		  	arr = np.arange(batch_size)
		  	np.random.shuffle(arr)
		  	image = train_data[0]
		  	keys = train_data[0][arr]
		  	Alice_vec = Alice.extract_latent(image)
		  	key_vec = Alice.extract_latent(keys)
		  	_,x,y,z = Alice_vec.size()
		  	Alice_vec = Alice_vec.reshape(batch_size,-1)
		  	Key_vec = Key_vec.reshape(batch_size,-1)
		  	oup_vec = FFN.Encode_Decode(Alice_vec,Key_vec)
		  	oup_vec = oup_vec.reshape(-1,x,y,z)
		  	B_image = Bob.distract_latent(oup_vec)
		  	E_image = Eve.distract_latent(oup_vec)
		  	criterion = nn.MSEloss()
		  	loss = criterion(image, B_image) - criterion(image, E_image)
		  	if i%100 == 0:
		  		print(loss)
		  		print("Alice-Bob's p1 Loss is", criterion(image, B_image))
		  		print("Eve's p1 is loss", criterion(image, E_image))
		  		loss.backward()
		  		FFN_optim.step()
		  		train_loss_ba += loss.item() 

      print("The Adversarial Loss for first phase is :" , train_loss_ba / len(train_data_loader))
      if (train_loss_ba / len(train_data_loader)) < min_train_loss_ba : 
        min_train_loss_ba = train_loss_ba / len(train_data_loader)
        torch.save(FFN.state_dict(),"FFN_GAN.pth")

    for z in range(Eve_epoch):
      print("The Epoch is:",j)
      train_loss_e = 0
      min_train_loss_e = 100
      for i,train_data in enumerate(train_data_loader):
        Eve_optim.zero_grad()
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
        E_image = Eve.distract_latent(oup_vec)
        criterion = nn.MSELoss()
        loss = criterion(image,B_image) - criterion(image,E_image)
        if i%100 == 0:
          print(loss)
          print("Alice-Bob's p2 Loss is",criterion(image,B_image))
          print("Eve's p2 Loss is" , criterion(image,E_image) )
        loss.backward()
        Eve_optim.step()
        train_loss_e += loss.item()    

      print("The Adversarial Loss for second phase is :" , train_loss_ba / len(train_data_loader))
      if (train_loss_e / len(train_data_loader)) < min_train_loss_e : 
          min_train_loss_e = train_loss_e / len(train_data_loader)
          torch.save(FFN.state_dict(),"Eve_GAN.pth")
if __name__ == "__main__"
    parser = argparse.ArgumentParser(description = 'Process some itegers.')
    parser.add_argument('-batch_size', type = int, default = 32, help = 'Training batch size')
    parser.add_argument('-lr', type = float, default = 0.001, help = 'learning rate')
    parser.add_argument('-GAN_epoch', type = int, default = 5)
		parser.add_argument('-Alice_epoch', type = int, default = 10) 
		parser.add_argument('-Eve_epoch', type = int, default = 10) 
		parser.add_argument('-dataset_path', type = str, default = "Dataset/101_ObjectCategories")
		parser.add_argument('-convencoder_path', type = str, default = "ConvAutoEncoder.pth")
    parser.add_argument('-deep_FFN_path', type = str, default = "FFN.pth")
    parser.add_argument('-Eve_checkpt', type = str, default = "Eve.pth")
    args = parser.parse_args()
    Alice, Bob, Eve = ConvAutoencoder(), ConvAutoencoder(), ConvAutoencoder()
    Alice.load_state_dict(torch.load(args.convencoder_path))
    Bob.load_state_dict(torch.load(args.convencoder_path))
    Eve.load_state_dict(torch.load(args.Eve_checkpt))
    FFN = CombineLatent(256)
    FFN.load_state_dict(torch.load(args.deep_FFN_path))
    train_loader, valid_loader = get_train_valid_loader(args.dataset_path, args.batch_size, True, 1234)
    FFN_optim = torch.optim.Adam(FFN.parameters(), lr = args.lr)
    Eve_optim = torch.optim.Adam(Eve.parameters(), lr = args.lr)
    Adversarial_training(Alice, Eve, Bob, FFN, train_loader, valid_loader, args.batch_size, FFN_optim, Eve_optim, args.GAN_epoch, args.Alice_epoch, args.Eve_epoch)





