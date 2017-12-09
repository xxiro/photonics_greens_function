function val = get_one_eig_vec(M, N)
% GET_ONE_EIG_VECTOR
% Returns the eigenvector with eigenvalue closest to 1
%
% Parameters:
% - M: square NxN matrix input
% - N: width of M

[V,D] = eig(M);

arr = zeros(N,1);

for i=1:N
    arr(i) = D(i,i);
end
arr = abs( arr - 1);


[~,index] = min(arr);

val = V(:,index);

end