clear all;clc
 escena='C:\Users\Public\Pictures\Sample Pictures\navidad.png'; %Escena
 maskobj='C:\Users\Public\Pictures\Sample Pictures\abirdprincipalmask.jpg'; %Mascara
 objeto ='C:\Users\Public\Pictures\Sample Pictures\abirdprincipal.jpg';


imgscene=imread(escena);
imgscene=imresize(imgscene,.2,'bilinear');
maskobj=imread(maskobj);
objeto=imread(objeto);
figure(1);
imshow(imgscene)
[imgy imgx imgrgb]=size(imgscene);
clear imgrgb imgx
for i=1:140
[x,y]=ginput(1);
x=floor(x);y=floor(imgy-y);
max(max(imgscene(:,:,1)))
imgscene=insOBJtoIMG(imgscene, objeto, maskobj, [x y], .01, 0);
imshow(imgscene);drawnow;
end
for i=1:30
[x,y]=ginput(1);
x=floor(x);y=floor(imgy-y);
max(max(imgscene(:,:,1)))
imgscene=insOBJtoIMG(imgscene, objeto, maskobj, [x y], .02, 0);
imshow(imgscene);drawnow;
end

for i=1:20
[x,y]=ginput(1);
x=floor(x);y=floor(imgy-y);
max(max(imgscene(:,:,1)))
imgscene=insOBJtoIMG(imgscene, objeto, maskobj, [x y], .03, 0);
imshow(imgscene);drawnow;
end
for i=1:5
[x,y]=ginput(1);
x=floor(x);y=floor(imgy-y);
max(max(imgscene(:,:,1)))
imgscene=insOBJtoIMG(imgscene, objeto, maskobj, [x y], .05, 0);
imshow(imgscene);drawnow;
end
for i=1:3
[x,y]=ginput(1);
x=floor(x);y=floor(imgy-y);
max(max(imgscene(:,:,1)))
imgscene=insOBJtoIMG(imgscene, objeto, maskobj, [x y], .1, 0);
imshow(imgscene);drawnow;
end
for i=1:1
[x,y]=ginput(1);
x=floor(x);y=floor(imgy-y);
max(max(imgscene(:,:,1)))
imgscene=insOBJtoIMG(imgscene, objeto, maskobj, [x y], .3, 0);
imshow(imgscene);drawnow;
end


