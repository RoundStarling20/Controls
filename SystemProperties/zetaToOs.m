function Os = zetaToOs(zeta)
% Written By: RoundStarling20
%    Created: Febuary 09 2022
%   Modified: Febuary 09 2022
%
%
%  Function Description:  
%      The purpose of this program is to calculate the overshoot given the
%          dampening ratio (zeta)
%
% INPUTS:
%  zeta:    Dampening ratio.
%
% OUTPUTS:
%  os:      Overshoot (as a percentage)
%
%
% Example Code:
%
% zeta = zetaToOs(0.7071)
% 
% zeta =
% 
%     4.3217

Os = exp((-pi * zeta)/(sqrt(1-zeta^2))) * 100;
end
