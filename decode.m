% Author: Hussain Al Zerjawo
% Class: CS390S
% Final
% Date: 12/11/2019

clear all; 
clc; 

filename = 'output\output_img.xlsx'; 
input_image = xlsread(filename); 

height = size(input_image, 1); 
width = size(input_image, 2); 
  
chars = 17;  
message_length = chars * 8;   
counter = 1; 
  
for i = 1 : height 
    for j = 1 : width 
        if (counter <= message_length)  
            extracted_bits(counter, 1) = mod(double(input_image(i, j)), 2); 
            counter = counter + 1; 
        end
    end
end
  
binValues = [ 128 64 32 16 8 4 2 1 ]; 
  
binMatrix = reshape(extracted_bits, 8,(message_length/8)); 
  
textString = char(binValues*binMatrix);  
 
disp(textString); 
