function [wn,zeta,Ts,Tp,Tr,Os,wd] = characteristics(coefficients)
% Written By: RoundStarling20
%    Created: Febuary 07 2022
%   Modified: August 31 2022
%
%
%  Function Description:  
%      The purpose of this program is to calculate various characteristics
%          of a transfer fucntion.
%
% INPUTS:
%  coefficients:    Coefficients of the denominator of a second order
%                   transfer function
%
% OUTPUTS:
%  zeta:    Dampening ratio.
%  wn:      Natural Frequency.
%  Ts:      Settling time.
%  Tp:      Time peak.
%  Tr:      Rise Time.
%  Os:      Overshoot (as a percentage)
%  wd:      Speed
%
%
% Example Code:
% [zeta,Wn,Ts,Tp,Tr,Os, wd] = characteristics([1,3,16])
% 
% zeta =
% 
%     0.3750
% 
% 
% Wn =
% 
%      4
% 
% 
% Ts =
% 
%     2.6667
% 
% 
% Tp =
% 
%     0.8472
% 
% 
% Tr =
% 
%     0.3559
% 
% 
% Os =
% 
%    28.0597
% 
% 
% wd =
% 
%     3.7081

if length(coefficients) > 3 || length(coefficients) < 3
    error('Input should be of length 3')
else
    wn = sqrt(coefficients(1,3));
    zeta = coefficients(1,2) /(2*wn);
    Tp = pi/(wn*sqrt(1-zeta^2));
    if zeta < 0.9 && zeta > 0.1
        %This equation is only valid for 0.1 < zeta < 0.9
        Ts = 4/(zeta * wn);
    else
        warning(['Since Z is not reasonable '...
            '(0.1 < zeta < 0.9) approximations are being made'])
        Ts = 1/(zeta * wn)*-log(0.02*sqrt(1-zeta^2));
    end
    Tr = (1/wn)*(1.76 * zeta^3 - 0.417*zeta^2 + 1.039*zeta + 1);
    Os = zetaToOs(zeta);
    wd = pi/Tp;
end
end