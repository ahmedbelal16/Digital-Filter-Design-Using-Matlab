% input  : vectors b (LPF/HPF numerator coeff.)
%          a (LPF/HPF denominator coeff.)
% return : vectors B (HPF/LPF numerator coeff.)
%          A (HPF/LPF denominator coeff.)
function [B, A]= LPF_transform_HPF(b,a)
    n_b = length(b);
    n_a = length(a);
    % we want to replace each z with -z but due that z terms are organized
    % as even power, odd, even, odd , ... so z -> -z will result in
    % +, -, +, -, ... so we want to multiply be this sign sequence
    sign_mask_b = (-1).^(0:n_b-1); 
    sign_mask_a= (-1).^(0:n_a-1);

    B = b .* sign_mask_b;
    A = a .* sign_mask_a;
 
end

