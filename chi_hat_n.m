function val = chi_hat_n(x,ff)

if x == 0
    val = ff;
    return
end

val = 1/(2*pi*1i)*(1./x).*(1-exp(-1i*2*x*pi*ff));

end
