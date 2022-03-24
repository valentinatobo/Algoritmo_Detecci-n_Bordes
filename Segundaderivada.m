%fila con primera y ultima
clear all;

%Carga de la Imagen plana
Imagen_plana = imread('imagen2.jpeg');
%Imagen_plana = imread('mickey.jpeg');
%Converción a la escala de grises
Imagen_plana_gris=rgb2gray(Imagen_plana);
%Dimensiones matriz de la imagen
[fila,columna] = size(Imagen_plana_gris);

%ANALISIS VERTICAL
%Distribución de brillantez promedio a partir de la imagen para reducir la influencia de la interferencia 
Av=[]; %Matriz promedio local de brillantez 
for i=1:fila
    for j=1:columna
        if i == 1
            Av(i,j)=(Imagen_plana_gris(i,j)+Imagen_plana_gris(i+1,j))/2;
        elseif i == fila
            Av(i,j)=(Imagen_plana_gris(i-1,j)+Imagen_plana_gris(i,j))/2;
        else
            Av(i,j)=(Imagen_plana_gris(i-1,j)+Imagen_plana_gris(i,j)+Imagen_plana_gris(i+1,j))/3;
        end
    end
end

%distribución de la primera diferencia promedio a partir de la distribución de brillantez promedio
Fv=[]; %matriz diferencia promedio de brillantez promedio
%Dimensiones matriz promedio local de brillantez
[filaA,columnaA] = size(Av);

for i=1:filaA
    for j=1:columnaA
        if i == 1
            Fv(i,j)=(Av(i+1,j)-Av(i,j))/2;
        elseif i == filaA
            Fv(i,j)=(Av(i,j)-Av(i-1,j))/2;
        else
            Fv(i,j)=(Av(i+1,j)-Av(i-1,j))/2;
        end
    end
end

% distribución de segunda diferencia promedio mediante el promedio de las primeras diferencias de la distribución
SV=[]; % Matriz distribución de segunda diferencia
%Dimensiones matriz diferencia promedio de brillantez promedio
[filaF,columnaF] = size(Fv);

for i=1:filaF
    for j=1:columnaF
        if i == 1
            SV(i,j)=(Fv(i+1,j)-Fv(i,j))/2;
        elseif i == filaF
            SV(i,j)=(Fv(i,j)-Fv(i-1,j))/2;
        else
            SV(i,j)=(Fv(i+1,j)-Fv(i-1,j))/2;
        end
    end
end


%ANALISIS HORIZONTAL

%Distribución de brillantez promedio a partir de la imagen para reducir la influencia de la interferencia 
Ah=[]; %Matriz promedio local de brillantez 
for i=1:fila
    for j=1:columna
        if j ==1
            Ah(i,j)=(Imagen_plana_gris(i,j)+Imagen_plana_gris(i,j+1))/2;
        elseif j == columna
            Ah(i,j)=(Imagen_plana_gris(i,j-1)+Imagen_plana_gris(i,j))/2;
        else 
            Ah(i,j)=(Imagen_plana_gris(i,j-1)+Imagen_plana_gris(i,j)+Imagen_plana_gris(i,j+1))/3;
        end 
    end
end

%distribución de la primera diferencia promedio a partir de la distribución de brillantez promedio
Fh=[]; %matriz diferencia promedio de brillantez promedio
%Dimensiones matriz promedio local de brillantez
[filaA,columnaA] = size(Ah);
for i=1:filaA
    for j=1:columnaA
        if j ==1
            Fh(i,j)=(Ah(i,j+1)-Ah(i,j))/2;
        elseif j == columnaA
            Fh(i,j)=(Ah(i,j)-Ah(i,j-1))/2;
        else 
            Fh(i,j)=(Ah(i,j+1)-Ah(i,j-1))/2;
        end    
    end
end

% distribución de segunda diferencia promedio mediante el promedio de las primeras diferencias de la distribución
SH=[]; % Matriz distribución de segunda diferencia
%Dimensiones matriz diferencia promedio de brillantez promedio
[filaF,columnaF] = size(Fh);

for i=1:filaF
    for j=1:columnaF
        if j ==1
            SH(i,j)=(Fh(i,j+1)-Fh(i,j))/2;
        elseif j == columnaF
            SH(i,j)=(Fh(i,j)-Fh(i,j-1))/2;
        else 
            SH(i,j)=(Fh(i,j+1)-Fh(i,j-1))/2;
        end   
    end
end


resultante =[];
umbral = 2;
for i=1:filaF
    for j=1:columnaF
        resultante(i,j)=sqrt(((SH(i,j))^(2))+((SV(i,j))^(2)));
        
        if resultante(i,j)<umbral
            resultante(i,j)=0;
        elseif resultante(i,j)>=umbral
            resultante(i,j)=255;
        end
    end 
end


%Mostrar las imagenes planas 
subplot(2,5,1);
imshow(Imagen_plana);
title('Imagen Normal');
subplot(2,5,2);
imshow(Imagen_plana_gris);
title('Imagen en escala de grises');
subplot(2,5,3);
imshow(SH);
title('Binarizada Aproximación Horizontal');
subplot(2,5,4);
imshow(SV);
title('Binarizada Aproximación Vertical');
subplot(2,5,5);
imshow(resultante);
title('Binarizada Aproximación');

%Carga de la Imagen plana
foto = imread('mickey.jpeg');
%Converción a la escala de grises
Foto_gris=rgb2gray(foto);
%Dimensiones matriz de la imagen
[fila,columna] = size(Foto_gris);

%ANALISIS VERTICAL
%Distribución de brillantez promedio a partir de la imagen para reducir la influencia de la interferencia 
Av=[]; %Matriz promedio local de brillantez 
for i=1:fila
    for j=1:columna
        if i == 1
            Av(i,j)=(Foto_gris(i,j)+Foto_gris(i+1,j))/2;
        elseif i == fila
            Av(i,j)=(Foto_gris(i-1,j)+Foto_gris(i,j))/2;
        else
            Av(i,j)=(Foto_gris(i-1,j)+Foto_gris(i,j)+Foto_gris(i+1,j))/3;
        end
    end
end

%distribución de la primera diferencia promedio a partir de la distribución de brillantez promedio
Fv=[]; %matriz diferencia promedio de brillantez promedio
%Dimensiones matriz promedio local de brillantez
[filaA,columnaA] = size(Av);

for i=1:filaA
    for j=1:columnaA
        if i == 1
            Fv(i,j)=(Av(i+1,j)-Av(i,j))/2;
        elseif i == filaA
            Fv(i,j)=(Av(i,j)-Av(i-1,j))/2;
        else
            Fv(i,j)=(Av(i+1,j)-Av(i-1,j))/2;
        end
    end
end

% distribución de segunda diferencia promedio mediante el promedio de las primeras diferencias de la distribución
SV=[]; % Matriz distribución de segunda diferencia
%Dimensiones matriz diferencia promedio de brillantez promedio
[filaF,columnaF] = size(Fv);

for i=1:filaF
    for j=1:columnaF
        if i == 1
            SV(i,j)=(Fv(i+1,j)-Fv(i,j))/2;
        elseif i == filaF
            SV(i,j)=(Fv(i,j)-Fv(i-1,j))/2;
        else
            SV(i,j)=(Fv(i+1,j)-Fv(i-1,j))/2;
        end
    end
end


%ANALISIS HORIZONTAL

%Distribución de brillantez promedio a partir de la imagen para reducir la influencia de la interferencia 
Ah=[]; %Matriz promedio local de brillantez 
for i=1:fila
    for j=1:columna
        if j ==1
            Ah(i,j)=(Foto_gris(i,j)+Foto_gris(i,j+1))/2;
        elseif j == columna
            Ah(i,j)=(Foto_gris(i,j-1)+Foto_gris(i,j))/2;
        else 
            Ah(i,j)=(Foto_gris(i,j-1)+Foto_gris(i,j)+Foto_gris(i,j+1))/3;
        end 
    end
end

%distribución de la primera diferencia promedio a partir de la distribución de brillantez promedio
Fh=[]; %matriz diferencia promedio de brillantez promedio
%Dimensiones matriz promedio local de brillantez
[filaA,columnaA] = size(Ah);
for i=1:filaA
    for j=1:columnaA
        if j ==1
            Fh(i,j)=(Ah(i,j+1)-Ah(i,j))/2;
        elseif j == columnaA
            Fh(i,j)=(Ah(i,j)-Ah(i,j-1))/2;
        else 
            Fh(i,j)=(Ah(i,j+1)-Ah(i,j-1))/2;
        end    
    end
end

% distribución de segunda diferencia promedio mediante el promedio de las primeras diferencias de la distribución
SH=[]; % Matriz distribución de segunda diferencia
%Dimensiones matriz diferencia promedio de brillantez promedio
[filaF,columnaF] = size(Fh);

for i=1:filaF
    for j=1:columnaF
        if j ==1
            SH(i,j)=(Fh(i,j+1)-Fh(i,j))/2;
        elseif j == columnaF
            SH(i,j)=(Fh(i,j)-Fh(i,j-1))/2;
        else 
            SH(i,j)=(Fh(i,j+1)-Fh(i,j-1))/2;
        end   
    end
end


resultante =[];
umbral = 2;
for i=1:filaF
    for j=1:columnaF
        resultante(i,j)=sqrt(((SH(i,j))^(2))+((SV(i,j))^(2)));
        
        if resultante(i,j)<umbral
            resultante(i,j)=0;
        elseif resultante(i,j)>=umbral
            resultante(i,j)=255;
        end
    end 
end


%Mostrar las imagenes planas 
subplot(2,5,6);
imshow(foto);
title('Imagen Normal');
subplot(2,5,7);
imshow(Foto_gris);
title('Imagen en escala de grises');
subplot(2,5,8);
imshow(SH);
title('Binarizada Aproximación Horizontal');
subplot(2,5,9);
imshow(SV);
title('Binarizada Aproximación Vertical');
subplot(2,5,10);
imshow(resultante);
title('Binarizada Aproximación');