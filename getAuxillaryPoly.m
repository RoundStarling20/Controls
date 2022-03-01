function [row] = getAuxillaryPoly(values,inputLength,columnLength,i)
% Written By: RoundStarling20
%    Created: Febuary 27 2022
%   Modified: March 01 2022
%
%
%  Function Description:  
%      The purpose of this program is to create an auxilary polynomial for
%      the routhHurwitz function 
%
% INPUTS:
%        values:    table that has been computed by routhHurwitz
%   inputLength:    number of coefficents
%  columnLength:    number of columns
%             i:    row of zeros index
%
% OUTPUTS:
%  row:    auxilary polynomial derivative coefficient
%
%

syms s
sThings = sym(zeros(1,columnLength));
power = inputLength - i + 1;
for j = 1:columnLength
    sThings(j) = s.^(power);
    if power <= 0
        break;
    else
        power = power - 2;
    end
end
auxilaryPolynomial = sThings.* values(i-1,:);
fprintf('Auxlilary polynomial in row %d: ',i-1);
disp(sum(auxilaryPolynomial))
row = subs(diff(auxilaryPolynomial,s),1);
end
