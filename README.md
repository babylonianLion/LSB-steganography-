# LSB-steganography-
Towards the end of the semester we talked a little bit about steganography, and I got quite interested in the idea of altering some type of media form and hiding secret information in it without people knowing that there has been a change. That’s why I choose to do my project on LSB steganography with LSB meaning least significant bit. The potential problems in this project would be the limitations (length) of the secret message depending on the dimensions of the image, but since I am planning on using this project as a game where the purpose is to be the first one to decrypt the image and win the prize, a Steam key that can be used to receive a video game and the steam key is only 17 characters long including the dashes, thus the length of the secret message is not an issue. 
Detailed Description:

The first thing I would do is convert the image into a grayscale image, but since I am using a standard picture (lena_g.bmp) that was available on blackboard for this game competition, I did not need to convert it into a grayscale image. That’s why I commented out the rgb2gray.
%input=rgb2gray(input); 

Then if I had to face one of my problems regarding the length of my secret message, I would need to resize the image, but since my secret message is short enough, I don’t need to resize it. That’s why I commented this 
%input=rgb2gray(input); 
%input=imresize(input, [512 512]); 

Then I created a variable containing my secret message which is the Steam key.
message='M0I47-PQLN9-9IGY7'; 

Then I converted my secret message into the binary form and put them into separate rows and converting them into number arrays using.
len = length(message) * 8; 
ascii_value = uint8(message); 
bin_message = transpose(dec2bin(ascii_value, 8)); 
bin_message = bin_message(:); 
bin_num_message=str2num(bin_message); 

Afterwards I made a cope of my original image for the output so that I can alter the output image.
output = input; 

Then I created variables for the height, width, and a counter for the embedded bits.
height = size(input, 1); 
width = size(input, 2); 
embed_counter = 1; 

Finally, after completing those things now I can traverse through each pixel of the image and do the following steps. Convert the pixel value into the binary form then embed the next secret message bit by creating a temporary variable and comparing the least significant bit of the pixel value with the secret bit and set the temporary variable to zero if the LSB and secret bit value are the same and if they are not the same then set the temporary variable to one. Once the temporary variable is set then it gets added to the pixel value (not the binary form but the grayscale form being 0-255) This process of iteration is to be done till the complete length of the secret message bits are finished. This is represented as:
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

Once the traversing and encryption has been done I can finally write the secret image as a file.
imwrite(output, 'output\steganographyImage.jpg'); 

Furthermore, for my own experimentational sake I also created an excel file for my testing and decryption part.
