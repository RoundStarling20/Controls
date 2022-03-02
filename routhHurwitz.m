function [values,numberOfRHPPoles] = routhHurwitz(coefficients)
% Written By: RoundStarling20
%    Created: February 18 2022
%   Modified: March 01 2022
%
%
%  Function Description:  
%      The purpose of this program is to populate a Routh-Hurwitz table
%          and inform the user of system stability.
%
% INPUTS:
%  coefficients:    Coefficients of a function
%
% OUTPUTS:
%             values:          A symbolic matrix with the tables values,
%                              limit is taken from the left
%  numberOfRHPPoles:           The number of poles in the right half plane.
%
%
% Example Code:
% [values,numberOfRHPPoles] = routhHurwitz([1, 5, 12, 25, 45, 50, 82, 60, 84])
% Auxiliary polynomial in row 3: 7*s^6 + 35*s^4 + 70*s^2
%  
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


%% Constants
syms e
inputLength = length(coefficients);
halfInputLength = inputLength/2;
arbMatrix = sym(zeros(2));
columnLength = ceil(halfInputLength);
values = sym(zeros(inputLength,columnLength));

%% Populate Matrix
%fill in first row with odd coefficients
values(1,:) = coefficients(1:2:end);
%fill in second row with even coefficients
values(2,1:floor(halfInputLength)) = coefficients(2:2:end);

%% Checks if second row is all zeros or first col is
if (values(2,:) == 0)
        values(2,:) = getAuxillaryPoly(values,inputLength,columnLength,2);
elseif(values(2,1) == 0 && sum(double(values(2,:)) ~= 0) > 1)
    values(2,1) = e;
end

%% compute table
for i = 3:inputLength
    for j = 1:columnLength - 1
        arbMatrix(1:2,1:2) = values(i-2:i-1,[1,j+1]);
        values(i,j) = -1/(values(i-1,1)) * det(arbMatrix);
    end
    %checks if the other values of the row are zero, if not put e in
    %first column (row must be completed before the epsilon is added
    %initialized as a zeros array
    if((values(i,1) == 0) && (sum(double(values(i,:)) ~= 0) > 0))
            values(i,1) = e;
    elseif (values(i,:) == 0)
        values(i,:) = getAuxiliaryPoly(values,inputLength,columnLength,i);
    end
end

%% Take limit
values = limit(values,e,0,'left');

%% Check if new row of zeros appears
for i = 3:inputLength
    if (values(i,:) == 0)
        values(i,:) = getAuxillaryPoly(values,inputLength,columnLength,i);
    end
end

%% Determine if the system is stable
if nargout == 2
    numberOfRHPPoles = [];
    if isSymType(sym(coefficients),'number') == 1
        signOfFirstColumn = sign(double(values(:,1)'));
        if((sum((signOfFirstColumn == -1)) == inputLength) || (sum((signOfFirstColumn == 1)) == inputLength))
            numberOfRHPPoles = 0;
        else
            columnToBeEvaluated = double(values(:,1)');
            columnToBeEvaluated(columnToBeEvaluated == 0) = -1;
            pos = columnToBeEvaluated > 0; 
            numberOfRHPPoles = sum(xor(pos(1:end-1),pos(2:end)));
        end
    else
        warning('The system''s stability can''t be evaluated with symbolic variables.');
    end
end
end
