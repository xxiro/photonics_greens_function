function [rows, cols] = get_local_minima_2d(M)

rows = [];
cols = [];

size_M = size(M);

for i=2:(size_M(1)-1)
    for j=2:(size_M(2)-1)
        
        weight = 0;
        current_val = M(i,j);
        extraneous_vals = [M(i+1,j) M(i+1,j+1) M(i,j+1) M(i-1,j+1) ...
                            M(i-1,j) M(i-1,j-1) M(i,j-1) M(i+1,j-1)]';
        
        extraneous_vals = extraneous_vals - current_val;
        weight = weight + ...
                sum(sum( extraneous_vals > 0)) - ...
                10*sum(sum( extraneous_vals < 0));
        
        if weight >= 7
            rows = [rows i];
            cols = [cols j];
        end
    end
end