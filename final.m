% Author: Hussain Al Zerjawo
% Class: CS390S
% Final
% Date: 12/11/2019

clear all; 
clc; 
  
input = imread('lena_g.bmp'); 
  
%input=rgb2gray(input); 
%input=imresize(input, [512 512]); 
  
message='M0I47-PQLN9-9IGY7';  

len = length(message) * 8; 
ascii_value = uint8(message); 
bin_message = transpose(dec2bin(ascii_value, 8)); 
bin_message = bin_message(:); 
bin_num_message=str2num(bin_message); 
  
 
output = input; 

height = size(input, 1); 
width = size(input, 2); 
embed_counter = 1; 
  
for i = 1 : height 
    for j = 1 : width 
        if(embed_counter <= len) 
            LSB = mod(double(input(i, j)), 2); 
            temp = double(xor(LSB, bin_num_message(embed_counter))); 
            output(i, j) = input(i, j)+temp;  
            embed_counter = embed_counter+1; 
        end
    end
end
  

imwrite(output, 'output\steganographyImage.jpg'); 

filename = 'output\output_img.xlsx'; 
xlswrite(filename, output); 
