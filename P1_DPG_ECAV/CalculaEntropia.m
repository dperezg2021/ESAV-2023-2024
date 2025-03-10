function entropia = CalculaEntropia(Imagen)
[fil col] = size (Imagen);  % calcula el tamaño de la imagen en términos fila y columna
Iv = reshape(Imagen,1,[]); % vector de pixeles
Iv_tras= Iv'; % valores en columna para facilitar cálculo
[veces, numero ] = groupcounts(Iv_tras); % cuenta numero de ocurrencias de cada valor  
tamanio = length(numero); %cuenta  números de valores de pixeles únicos
elementos = fil*col; %calcula numero de pixeles totales

entropia = 0 ; % inicializamos variable entropia a 0
for i = 1:tamanio
        pi = veces(i)/elementos;
        entropia = entropia - (pi*log2(pi));
end

entropia;

end

