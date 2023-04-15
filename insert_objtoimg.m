function Escena = insOBJtoIMG(Escena, objeto, Mobj, puntoxy, esc, rot)
% La funcion insOBJtoIMG(escena, objeto, maskobj, puntoxy, esc, rot) 
% permite insertar un objeto de nxm dimenciones en una imagen de qxp 
% dimenciones los parametros que se insertan son:
%
% escena:  Debe de ser una imagen de qxpx3 dimenciones
% objeto:  Es la imagen del objeto segmentada con fondo negro. Las
%          dimensiones deben de ser de nxmx3.
% maskobj: Mascara del objeto, la dimencion debe de ser de nxmx3. Donde la
%          mascara del objeto es negra con fondo blanco.
% puntoxy: Es una vector [x y] donde define las coordenadas donde se quiere
%          intertar el objeto.
% esc:  Es una escalar que puede ir de .001 hasta 2 preferenmente, su
%       funcion es escalar el objeto dentro de la imagen. Un uno en este
%       parametro significa el objeto insertado en escala 1:1
% rot:  Rota el objeto en la imagen en la posicion deseada. Debe de ponerse
%       en grados.
%
% EJEMPLO
%  
% % Directorio de la imagen escena
% drss1 ='C:\Users\Public\Pictures\Sample Pictures\Escenaproyecto.jpg'; %Escena
% % Directorio de la imagen objeto
% drss2 ='C:\Users\Public\Pictures\Sample Pictures\abirdprincipal.jpg'; 
% % Directorio de la mascara
% drss3 ='C:\Users\Public\Pictures\Sample Pictures\abirdprincipalmask.jpg';
% Escena =  imread(drss1); % Read scene
% objeto =  imread(drss2); % Read obj
% mask =    imread(drss3); % Read mask.
% Escena = insOBJtoIMG(Escena, objeto, mask, [10 10], .1, 0);
% imshow(Escena)
%
% Author: Oliver G. Campos
%
 
%% index test of scene
if max(max(Escena(:,:,1))) > 2 && max(max(Escena(:,:,2))) > 2
Escena=mat2gray(Escena,[0 255]);
end    




%% Map coordenates (Just x axis)
puntoxy=[puntoxy(2) puntoxy(1)];
Tescena=size(Escena);   % Get size of the scene
puntoxy(1)=Tescena(1)-puntoxy(1);

%% Escala de la mascara y rotacion
Mobjesc = imresize(Mobj,esc,'bilinear');
Mobjesc=imcomplement(imrotate(imcomplement(Mobjesc),rot,'crop'));

[tx ty m] = size(Mobjesc);% Get size of mask
clear m % Unuseless m variable
cx = ceil(tx/2);
cy = ceil(ty/2);
% Build array around escena with the same obj dimentions
Escena = padarray(Escena,[tx ty]);
puntoxy(1)=puntoxy(1)+tx;% Adjust the point x to new dimesions of Escena
puntoxy(2)=puntoxy(2)+ty;% Adjust the point y to new dimesions of Escena
dx=abs(tx-2*cx); % Realine x size windows select
dy=abs(ty-2*cy); % Realine x size windows select
%% If every point puntoxy excess de dimensions of Escena don't do this
if ( (puntoxy(1) > cx) && (puntoxy(1) < Tescena(1)+tx+cx) && ...
     (puntoxy(2) > cy) && (puntoxy(2) < Tescena(2)+ty+cy))
  % Build a window with the same proportion that mask object
  Escenatemp=Escena((puntoxy(1)-cx):(puntoxy(1)+cx-1-dx),(puntoxy(2)-cy):(puntoxy(2)+cy-1-dy),:);
  % Multiply mask objeto and window
  Escenatemp=Escenatemp.*mat2gray(Mobjesc);
  % Adjust object to new dimensions of mask according to esc and rot
  % variables
  objeto = imresize(objeto,esc,'bilinear');
  objeto =imrotate(objeto,rot,'crop');
  % Insert object to the window
  Escenatemp=Escenatemp+mat2gray(objeto,[0 255]);
  % Put modify window in the same coodenates with the object include
  Escena((puntoxy(1)-cx):(puntoxy(1)+cx-1-dx),(puntoxy(2)-cy):(puntoxy(2)+cy-1-dy),:)= Escenatemp;
end
% Eliminate dark frame around image
Escena=Escena(tx+1:tx+Tescena(1),ty+1:ty+Tescena(2),:);
