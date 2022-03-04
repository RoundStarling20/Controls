function zeta = osToZeta(os)
% Written By: RoundStarling20
%    Created: Febuary 09 2022
%   Modified: Febuary 09 2022
%
%
%  Function Description:  
%      The purpose of this program is to calculate the dampening ratio
%          (zeta) given the overshoot
%
% INPUTS:
%  os:      Overshoot (as a percentage)
%
% OUTPUTS:
%  zeta:    Dampening ratio.
%
%
% Example Code:
% 
% os = osToZeta(4.32)
%
% os =
% 
%     0.7071

zeta = -log(os/100)/sqrt(pi^2 + (-log(os/100))^2);
end
