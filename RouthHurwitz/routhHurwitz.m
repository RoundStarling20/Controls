function [values,numberOfRHPPoles] = routhHurwitz(coefficients)
% Written By: RoundStarling20
%    Created: February 18 2022
%   Modified: September 18 2022
%
%
%  Function Description:  
%      The purpose of this program is to populate a Routh-Hurwitz table
%          and inform the user of system stability.
%
% INPUTS:
%  coefficients:    Coefficients of a function (symbolic or numeric),
%                   usually the charecteristic equation of a 
%                   transfer function.
%
% OUTPUTS:
%             values:          A symbolic matrix with the values of the
%                              table, limit is taken from the left
%  numberOfRHPPoles:           The number of poles in the right half-plane.
%
%
% Example Code:
% [values,numberOfRHPPoles] = routhHurwitz([1, 5, 12, 25, 45, 50, 82, 60, 84])
%  
% values =
%  
% [      1,     12,  45, 82, 84]
% [      5,     25,  50, 60,  0]
% [      7,     35,  70, 84,  0]
% [     42,    140, 140,  0,  0]
% [   35/3,  140/3,  84,  0,  0]
% [    -28, -812/5,   0,  0,  0]
% [    -21,     84,   0,  0,  0]
% [-1372/5,      0,   0,  0,  0]
% [     84,      0,   0,  0,  0]
%  
% 
% numberOfRHPPoles =
% 
%      2

%% Initial Input Check
if nargin < 1 || size(coefficients,1) > 1
    error(['Input a 1-D vector of polynomial coefficients entering '...
        'zeros where necessary.']);
end

%% Constants
syms e
inputLength = length(coefficients);
columnLength = ceil(inputLength/2);
values = sym(zeros(inputLength,columnLength));
arbMatrix = sym(zeros(2));

%% Populate Matrix
%fill in first row with odd coefficients
values(1,:) = coefficients(1:2:end);
%fill in second row with even coefficients
values(2,1:(inputLength - columnLength)) = coefficients(2:2:end);

%% compute table
for i = 3:inputLength
    if(values(i-1,1) == 0)
        %check if row of zeros has occurred
        if (values(i-1,2:end) == 0)
            values(i-1,:) = getAuxiliaryPoly(values(i-2,:), ... 
                inputLength,columnLength,i-1);           
        %if not row of zeros, then case 1 has occured
        else
            values(i-1,1) = e;
        end
    end
    %compute index
    for j = 1:columnLength - 1
        arbMatrix(1:2,1:2) = values(i-2:i-1,[1,j+1]);
        values(i,j) = -1/(values(i-1,1)) * det(arbMatrix);
    end
end

%% Take limit
values = limit(values,e,0,'left');

%% Check if new row of zeros appears
for i = 3:inputLength
    if (values(i,:) == 0)
        values(i,:) = getAuxiliaryPoly(values(i-1,:),inputLength,columnLength,i);
    end
end

%% Determine if the system is stable
if nargout == 2
    numberOfRHPPoles = [];
    if isSymType(sym(coefficients),'number') == 1
        columnToBeEvaluated = double(values(:,1)');
        columnToBeEvaluated(columnToBeEvaluated == 0) = -1;
        positive = columnToBeEvaluated > 0;
        %xor of the shifted matricies will be the changes in sign
        numberOfRHPPoles = sum(xor(positive(1:end-1),positive(2:end)));
    else
        warning(['The system''s stability can''t ' ...
            'be evaluated with symbolic variables.']);
    end
end
end

function [row] = getAuxiliaryPoly(values,inputLength,columnLength,i)
% Written By: RoundStarling20
%    Created: February 27 2022
%   Modified: March 03 2022
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
%  row:    Auxiliary polynomial derivative coefficients
%
%

power = inputLength - i + 1;
exponents = power:-2:0;
if length(exponents) > columnLength
    exponents(columnLength+1:end) = [];
else
    exponents(end+1:columnLength) = 0;
end
row = exponents.* values;
end 