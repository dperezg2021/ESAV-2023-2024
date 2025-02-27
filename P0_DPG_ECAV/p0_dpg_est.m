% Ejercicio1

A = [1 2 -1 3;
     2 0 2 -1;
    -1 1 1 -1;
     3 3 -1 2];

B = [ -8; 13; 8; -1];

inversa = inv(A);

Sol = inversa *B
%% 

% Ejercicio2

A = [ 1 3 4;
      7 8 -4;
      0 4 2];
B = [10; 5; 9];

OperacionesMatriz(A,B)
%% 
%Ejercicio3 

%Pregunta el tamaño de la matriz

num = input ("Indique el tamaño de la matriz\n");

A = fix (10*rand(num) )
B = [];

for j = 2:2:num
    B = [B A(:,j)];
end
B
M_diagoanl = diag(A)
A_traspuesta = A';
Val_max = max (A_traspuesta)
Val_min = min (A_traspuesta)
valor_medio = mean(A_traspuesta)
Varianza = var(A_traspuesta)
%% Ejercicio 4
clear all; close all; clc;

cadena=[];
for d = 50:-1:1
    cadena = [cadena num2str(d)];

    if d >1 
        cadena = [cadena, ' '];
    end
end
disp (['cadena_resultante: ', cadena]);
%% Ejercico 5
clear all; close all; clc;

A= []; %inicializamos a 0 la matriz 0 
 for dimension = 1 :100 
     A = rand(dimension)
     tic; %calcular tiempo de cálculo rango
        rango_matriz = rank(A);
     r(dimension) = toc; %detener tempo y obtener el tiempo transcurrido
    tic;%caclular tiempo determinante
        determinante_matriz = det(A);
    d(dimension) = toc; 
 end
 A
 matriz_rangos = r';
 matriz_determinantes = d';

figure;

subplot(2,1,1);
plot (1:100, matriz_rangos, '-o','LineWidth',1.5);
title('Grafica de rangos');
xlabel('Tamaño de la matriz');
ylabel('Tiempo(seg)');
legend('Tiempo de calculo del rango');

subplot(2,1,2);
plot (1:100, matriz_determinantes, '-o','LineWidth',1.5);
title('Grafica de determinantes');
xlabel('Tamaño de la matriz');
ylabel('Tiempo(seg)');
legend('Tiempo de calculo del Determinante');

%% Ejercicio 6
close all;
clear all;
clc;

for i = 1 :100
matriz(:,:,i)= rand(2);

end
matriz_80 = matriz(:,:,80);
matriz_80
matriz(:,:,40) = [5 6;
                  7 8];

matriz_40 = matriz (:,:,40)
f = reshape(matriz, [1, 400]);
f 

%% Ejercicio 7 
close all;
clear all;
clc;

imagen = imread('niebla_640x456 (1).jpg');
bits_pixel = numel(class(imagen));

pixel_mayor_128 = sum(imagen(:)>128);

fprintf('Bits por pixel: %d\n', bits_pixel);
fprintf('Número de pixeles que superan el valor de 128 %d\n', pixel_mayor_128);

%% Ejercicio 8
close all;
clear all;
clc;

x = linspace(-5, 5, 100);
y = linspace(-5, 5, 100);
[X, Y] = meshgrid(x,y);

Z = Y.*sin(pi*(X/5)) + 5 *cos((X^2 + Y^2)/4) + cos(X+Y) * cos(3*X - Y) + sin(X +Y)

figure;

%superficie

subplot(1, 3, 1);
surf(X,Y,Z);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Superficie');

%malla
subplot(1, 3, 2);
mesh(X,Y,Z);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Superficie con malla');

%Contorno
subplot(1, 3, 3);
contourf(X,Y,Z);
xlabel('X');
ylabel('Y');
title('Contorno');

%% Ejercicio 9 

clear all;
close all;
clc;
syms x

d= x^3 +3*x -5;

derivada = diff(d)
integral = int(d)
resolu = solve(d)



A = [1 2 -1 3;
     2 0 2 -1;
    -1 1 1 -1;
     3 3 -1 2];

B = [ -8; 13; 8; -1];

solucion_matriz = linsolve(A, B)

