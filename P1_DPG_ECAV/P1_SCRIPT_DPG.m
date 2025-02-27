%%Ejercicio 1.1
clear all; close all; clc;
imagen = imread('arbol_640x426.jpg');

imshow(imagen);

%dimesión de matriz 
[filas, columnas, colores] = size(imagen)

fprintf('Dimensiones de la imagen : %d filas x %d columnas x %d colores\n', filas, columnas, colores);
%% Ejercicio 1.2
clear all; close all; clc;
Imagen_RGB = imread('arbol_640x426.jpg');

Imagen_YCbCr = RGBTOYCbCr(Imagen_RGB);

% Extraer las componentes Y, Cb y Cr
Y = uint8(Imagen_YCbCr(:,:,1));
Cb = uint8(Imagen_YCbCr(:,:,2));
Cr = uint8(Imagen_YCbCr(:,:,3));

% Crear una figura para mostrar las componentes YCbCr
figure;

% Componente Y
subplot(1, 3, 1);
imshow(Y);
title('Componente Y');

% Componente Cb
subplot(1, 3, 2);
imshow(Cb);
title('Componente Cb');

% Componente Cr
subplot(1, 3, 3);
imshow(Cr);
title('Componente Cr');


%% Ejercicio 2
clear all; close all; clc;
arbol = imread('arbol_640x426.jpg');
caballos= imread('caballos_640x427.jpg');
niebla = imread('niebla_640x456 (2).jpg');

arbol_gris= rgb2gray(arbol);
caballos_gris= rgb2gray(caballos);
niebla_gris= rgb2gray(niebla);

entropia_arbol_gris = CalculaEntropia(arbol_gris)
entropia_caballos_gris = CalculaEntropia(caballos_gris)
entropia_niebla_gris = CalculaEntropia(niebla_gris)


imagen_concatenada =  [arbol_gris; caballos_gris; niebla_gris];
imshow(imagen_concatenada)

entropia_conjunta = CalculaEntropia(imagen_concatenada)

%% EJERCICIO 3
clear all; close all; clc;

% 3.1: Cargar la imagen, convertirla a escala de grises y luego a blanco y negro
imagen_icono = imread('icono_8x8.jpg');
imagen_gris = rgb2gray(imagen_icono);
imagen_bn = imbinarize(imagen_gris);

% 3.2: Obtener las probabilidades de ocurrencia de cada símbolo en la imagen en blanco y negro
probabilidades = zeros(1, 2); % Inicializar vector de probabilidades [0, 0]
[filas, columnas] = size(imagen_bn);
total_pixeles = filas * columnas;

% Contar la cantidad de píxeles blancos y negros
blancos = sum(imagen_bn(:) == 1);
negros = sum(imagen_bn(:) == 0);

% Calcular las probabilidades de ocurrencia de cada símbolo
probabilidades(1) = blancos / total_pixeles; % Probabilidad de blanco
probabilidades(2) = negros / total_pixeles;  % Probabilidad de negro

% 3.4. Converitr a decimal el código binario generado y obtener el rendimiento del codificador

image_bn_vector = imagen_bn(:);

% Convertir el número binario a decimal
numero_decimal = bi2de(image_bn_vector', 'left-msb');


% Calcular el rendimiento del codificador
longitud_media_simbolo = probabilidades(1)+ probabilidades(2); 
eficiencia_codificador = CalculaEntropia(imagen_bn)/ longitud_media_simbolo;

% Mostrar resultados
disp('Probabilidades de ocurrencia de cada símbolo:');
disp(['Probabilidad de blanco: ', num2str(probabilidades(1))]);
disp(['Probabilidad de negro: ', num2str(probabilidades(2))]);
disp(' ');

disp(['El valor decimal es igual a ', num2str(numero_decimal) ]);
disp(['Rendimiento del codificador: ', num2str(eficiencia_codificador)]);

