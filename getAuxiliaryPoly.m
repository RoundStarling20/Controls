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

power = inputLength - i + 1;
exponents = power:-2:0;
if length(exponents) > columnLength
    exponents(columnLength+1:end) = [];
else
    exponents(end+1:columnLength) = 0;
end
row = exponents.* values(1,:);
end
