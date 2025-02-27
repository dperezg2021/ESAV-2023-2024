function OperacionesMatriz(A, B)

trasA = A'
trasB = B'
inverA = inv(A)
detA = det (A)
RangoA = rank(A)
produc_matr = A*B
produc_elem = A(:,1).*B(:)
vect_fila = [A(1,:), B(1)]
vect_columna = [A(:,1), B(:)]
end

