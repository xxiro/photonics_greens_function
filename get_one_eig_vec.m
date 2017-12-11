function val = get_one_eig_vec(M, N)
% GET_ONE_EIG_VECTOR
% Returns the eigenvector with eigenvalue closest to 1
%
% Parameters:
% - M: square NxN matrix input
% - N: width of M

[V,D] = eig(M, eye(N));

arr = 10000*ones(N,1);

for i=1:N
    if isfinite(D(i,i)) == 1
        arr(i) = D(i,i);
    end
end
arr = abs( arr - 1);


[~,index] = min(arr);

val = V(:,index);

end