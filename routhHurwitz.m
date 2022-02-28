function values = routhHurwitz(coefficients)
% Written By: RoundStarling20
%    Created: Febuary 18 2022
%   Modified: Febuary 26 2022
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
%  values:    A symbolic matrix with the tables values, limit is taken from
%           the left
%
%

%% Constants
syms e s
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
        symbolic = sym(zeros(1,columnLength));
        power = inputLength - 2 + 1;
        symbolic(1:power) = s.^(power:-2:0);
        auxilaryPolynomial = symbolic.* values(2-1,:);
        values(2,:) = subs(diff(auxilaryPolynomial,s),1);
        fprintf('Second row needed an auxilary polynomial');
elseif(values(2,1) == 0 && sum(double(values(2,:)) ~= 0) > 1)
    values(2,1) = e;
end
%% compute table
for i = 3:inputLength
    for j = 1:columnLength - 1
        %arbMatrix(1,1) = values(i-2,1);
        %arbMatrix(1,2) = values(i-2,j+1);
        %arbMatrix(2,1) = values(i-1,1);
        %arbMatrix(2,2) = values(i-1,j+1);
        arbMatrix(1:2,1:2) = values(i-2:i-1,[1,j+1]);
        values(i,j) = -1/(values(i-1,1)) * det(arbMatrix);
        
        %checks if the other values of the row are zero, if not put e in
        %first column (row must be completed before the epsilon is added
        %initizized as a zeros array
        if((values(i,1) == 0) && (sum(double(values(i,:)) ~= 0) > 1) && (j == columnLength - 1))
            values(i,1) = e;
        end
    end
    if (values(i,:) == 0)
        symbolic = sym(zeros(1,columnLength));
        power = inputLength - i + 1;
        symbolic(1:power) = s.^(power:-2:0);
        auxilaryPolynomial = symbolic.* values(i-1,:);
        values(i,:) = subs(diff(auxilaryPolynomial,s),1);
        fprintf('Used an auxilary polynomial\n');
    end
end
%% Take limit
values = limit(values,e,0,'left');
%% Check if new row of zeros appears
for i = 3:inputLength
    if (values(i,:) == 0)
        symbolic = sym(zeros(1,collumnLength));
        power = inputLength - i + 1;
        symbolic(1:power) = s.^(power:-2:0);
        auxilaryPolynomial = symbolic.* values(i-1,:);
        values(i,:) = subs(diff(auxilaryPolynomial,s),1);
        fprintf('Row of zeros appeared after limit, made an aux polynomial\n');
    end
end
end
