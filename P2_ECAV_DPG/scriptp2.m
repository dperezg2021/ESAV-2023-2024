%% PRÁCTICA 2

%% EJERCICIO 1
clear all; close all; clc;

%cargamos el vídeo
video = VideoReader("video_test_80x80.mp4");

% Obtenemos el número total de frames en el vídeo
numeroFrames = video.NumFrames;

% Inicializamos una matriz tridimensional para almacenar la luminancia de cada frame
Matrizluminancia = zeros(video.Height, video.Width, numeroFrames);

for frameIndex = 1:numeroFrames
    % Leer todos los frame
    frameRGB = read(video, frameIndex);
    
    % Convertir el frame a YCbCr
    frameYCbCr = rgb2ycbcr(frameRGB);
    
    % Extraer la componente de luminancia (Y)
    luminancia = frameYCbCr(:,:,1);
    
    % Convertir la imagen a tipo double y almacenarla en la matriz
    Matrizluminancia(:,:,frameIndex) = im2double(luminancia);
end

% Guardar la matriz tridimensional en un archivo .mat
save('Matrizlumininacia.mat', 'Matrizluminancia');


%% EJERCICIO 2
close all; clc;

load('Matrizlumininacia.mat','Matrizluminancia');

% dimensiones de la matriz
[height, width, numFrames] = size(Matrizluminancia);

% matriz para almacenar el error
errorMatriz = zeros(height, width, numFrames);
predictedValor = 0;

for frameIndex = 1:numFrames
    % Copiar la primera fila y la primera columna directamente a la matriz de predicción
    predicted = Matrizluminancia(:,:,frameIndex);
    
    % Aplicar la predicción intra-frame a partir del segundo píxel
    for row = 1:height
        for col = 1:width
            if (row == 1) || (col == 1)
                predicted(row, col) = Matrizluminancia(row, col, frameIndex);
            else
                % Calcular el valor utilizando los tres píxeles de referencia

                A = predicted(row, col-1);
                B = predicted(row-1, col);
                C = predicted(row-1, col-1);
    
                if C >= max(A,B)
                       predictedValor = min(A,B);
                elseif C <= min(A,B)
                        predictedValor = max(A,B);
                else 
                       predictedValor= A + B -C; 
                end

                    % Calcular el error como la diferencia entre el valor actual y el valor predicho
                    errorMatriz(row, col, frameIndex) = Matrizluminancia(row, col, frameIndex) - predictedValor;
                    matrizpred(row,col,frameIndex) = predictedValor;
            end
        end
    end
end

% Guardar la matriz de error en un archivo .mat
save('errorMatriz.mat', 'errorMatriz');
save('matrizpred.mat','matrizpred');

%% EJERCICIO 3

load('errorMatriz.mat', 'errorMatriz');

[height, width, numFrames] = size(errorMatriz);

dctCoef = zeros(height, width, numFrames);

% Aplicamos la transformada 2D-DCT a cada frame 
for frameIndex = 1:numFrames
    dctCoef(:,:,frameIndex) = dct2(errorMatriz(:,:,frameIndex));
end

% Calcular la entropía de la matriz de error original
entropyOriginal = entropy(Matrizluminancia);

% Calcular la entropía de la matriz de coeficientes DCT
entropyDCT = entropy(dctCoef);

% Mostrar la reducción de entropía
entropyReduction = entropyOriginal - entropyDCT;
disp(['Reducción de entropía: ', num2str(entropyReduction)]);
disp(['Entropía original: ', num2str(entropyOriginal)]);
disp(['Entropía coef: ', num2str(entropyDCT)]);

% Guardar la matriz de error en un archivo .mat
save('dctCoef.mat', 'dctCoef');

%% EJERCICIO 4 
close all; clc;

load('dctCoef.mat', 'dctCoef');
[height, width, numFrames] = size(dctCoef);

maximo_valor = max(dctCoef(:));
minimo_valor = min(dctCoef(:));

fprintf('El valor máximo en la matriz tridimensional es: %d\n', maximo_valor);
fprintf('El valor mínimo en la matriz tridimensional es: %d\n', minimo_valor);

cuantifValor = zeros(height, width, numFrames);
for i = 1: numFrames 
    cuantifValor(:,:,i) = fix(100 *dctCoef(:,:,i));
end

maximo1_valor = max(cuantifValor(:));
minimo1_valor = min(cuantifValor(:));

fprintf('El valor máximo en la matriz tridimensional cuantificada es: %d\n', maximo1_valor);
fprintf('El valor mínimo en la matriz tridimensional cuantificada es: %d\n', minimo1_valor);


% Guardar la matriz de error en un archivo .mat
save('cuantifValor.mat', 'cuantifValor');
%% EJERCICIO 5
load('cuantifValor.mat', 'cuantifValor');

Codigo = struct('codigo',{}, 'counts',{}, 'symbols',{} );
% Generar codificación aritmética para cada frame

for frameIndex = 1:numFrames
    vector = reshape(cuantifValor(:,:,frameIndex), 1, []);
    % Obtener los símbolos únicos y su conteo para el frame actual
    [symbols, ~, seq] = unique(vector);
    counts = histc(vector, symbols);
    

    Codigo(frameIndex).codigo = arithenco(seq, counts);
    Codigo(frameIndex).simbolos = symbols;
    Codigo(frameIndex).counts = counts;
end

save('ejercicio5.mat', 'Codigo');
%% Ejercicio 6

load('ejercicio5.mat', 'Codigo');
load('matrizpred.mat','matrizpred');

% Inicializar una matriz para almacenar los frames decodificados
video_decodificado1 = zeros(height, width, numFrames);

% Decodificar cada frame
for frameIndex = 1:numFrames
    % Decodificar la secuencia para el frame actual
    decodificacion = arithdeco(Codigo(frameIndex).codigo, Codigo(frameIndex).counts, 6400);
    
    % Reconstruir la matriz del frame a partir de la secuencia decodificada
    video_decodificado1(:,:,frameIndex) = reshape(Codigo(frameIndex).simbolos(decodificacion), height, width);
end


video_decodificado2 = video_decodificado1/100;

inversa = zeros(height, width, numFrames);

for frameIndex = 1:numFrames
    inversa(:,:,frameIndex) = idct2(video_decodificado2(:,:,frameIndex));
end

video_decodificado4 = zeros(height, width, numFrames);

for frameIndex = 1:numFrames
    video_decodificado4(:,:,frameIndex) = inversa(:,:,frameIndex) + matrizpred(:,:,frameIndex);
end

figure;
subplot(2,2,1); imshow(Matrizluminancia(:,:,1)), title('Frame 1 original');
subplot(2,2,2); imshow(video_decodificado4(:,:,1)), title('Frame 1 reconstruido');
subplot(2,2,3); imshow(Matrizluminancia(:,:,499)), title('Frame 499 original');
subplot(2,2,4); imshow(video_decodificado4(:,:,499)), title('Frame 499 reconstruido');