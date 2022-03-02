function [row] = getAuxiliaryPoly(values,inputLength,columnLength,i)
% Written By: RoundStarling20
%    Created: February 27 2022
%   Modified: March 01 2022
%
%
%  Function Description:  
%      The purpose of this program is to create an auxiliary polynomial for
%      the routhHurwitz function 
%
% INPUTS:
%        values:    table that has been computed by routhHurwitz
%   inputLength:    number of coefficients
%  columnLength:    number of columns
%             i:    row of zeros index
%
% OUTPUTS:
%  row:    Auxiliary polynomial derivative coefficient
%
%

syms s
power = inputLength - i + 1;
sThings = s.^(power:-2:0);
if length(sThings) > columnLength
    sThings(columnLength+1:end) = [];
else
    sThings(end+1:columnLength) = 0;
end
auxiliaryPolynomial = sThings.* values(1,:);
fprintf('Auxiliary polynomial in row %d: ',i-1);
disp(sum(auxiliaryPolynomial))
row = subs(diff(auxiliaryPolynomial,s),1);
end
