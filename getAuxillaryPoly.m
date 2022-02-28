function [row] = getAuxillaryPoly(values,inputLength,columnLength,i)
% Written By: RoundStarling20
%    Created: Febuary 27 2022
%   Modified: Febuary 28 2022
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
symbolic = sym(zeros(1,columnLength));
power = inputLength - i + 1;
sThings = s.^(power:-2:0);
symbolic(1:length(sThings)) = sThings(1,:);
auxilaryPolynomial = symbolic.* values(i-1,:);
fprintf('Auxlilary polynomial in row %d: ',i);
disp(auxilaryPolynomial)
row = subs(diff(auxilaryPolynomial,s),1);
end
