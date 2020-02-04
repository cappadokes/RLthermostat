function [pmv ppd] = htc(ta, tr, rh, vel, met, clo, wme, pa)
%	HTC - HumanThermalComfort
% Computes the Predicted Mean Vote (PMV) and the Predicted Percentage of Dissatisfied (PPD) in accordance with ISO 7730.
%
% Syntax:  [pmv ppd]  = pmv(ta, tr, rh, vel, met, clo, wme, pa)
%
% Inputs:
%    input1 - Air temperature, °C
%    input2 - Mean radiant temperature, °C
%    input3 - Relative humidity, %
%    input4 - Relative air velocity, m/s
%    input5 - Metabolic rate, met
%    input6 - Clothing, clo
%    input7 - External work, met, normally around 0
%
%	ENTER EITHER RH OR WATER VAPOUR PRESSURE BUT NOT BOTH
%    input8 - Partial water vapour pressure, Pa
%
% Outputs:
%    output1 - Predicted Mean Vote (PMV)
%    output2 - Predicted Percentage of Dissatisfied (PPD)
%
%	clo - Clothing, clo
%	met - Metabolic rate, met
%	wme - External work, met
%	ta - Air temperature, °C
%	tr - Mean radiant temperature, °C
%	vel - Relative air velocity, m/s
%	rh - Relative humidity, %
%	pa - Partial water vapour pressure, Pa
%
% Example: 
%    [pmv ppd] = pmv(20, 26, 60)
%
% Other m-files required: none
% Subfunctions: fnps
% MAT-files required: none
%
%	Sources:
%	ANSI/ASHRAE Standard 55-2004
%	Thermal Environmental Conditions for Human Occupancy
%
% Author: Panayiotis Danassis
% email: panosd@microlab.ntua.gr
% Website: http://panosd.eu/
% October 2015; Last revision: 02-October-2015

function svp = fnps(t)
	%	FNPS - Computes the saturated vapour pressure, kPa
	svp = exp(16.6536 - 4030.183 / (t + 235));
end

%	Argument management:
%	arg1, arg2, arg3 are mandatory while the rest are optional.
if nargin < 8
   pa = 0;
end
if nargin < 7
   wme = 0;;
end
if nargin < 6
   clo = 1;
end
if nargin < 5
   met = 1;
end
if nargin < 4
   vel = 0.5;
end

%	Water vapour pressure, Pa
if pa == 0
	pa = rh * 10 * fnps(ta);
end
%	Thermal insulation of the clothing, m^2K/W
icl = 0.155 * clo;
% Metabolic rate, W/m^2
m = met * 58.15;
% External work, W/m^2
w = wme * 58.15;
% Internal heat production in the human body
mw = m - w;
% Clothing area factor
if icl <= 0.078
	fcl = 1 + 1.29 * icl;
else
	fcl = 1.05 + 0.645 * icl;
end
% Heat transfer coefficient by forced convection
hcf = 12.1 * sqrt(vel);
% Air temperature in Kelvin
taa = ta + 273;
% Mean radiant temperature in Kelvin
tra = tr + 273;

% Calculate surface temperature of clothing iteratively
% First guess for surface temperature of clothing
tcla = taa + (35.5 - ta) / (3.5 * (6.45 * icl + 0.1));
p1 = icl * fcl;
p2 = p1 * 3.96;
p3 = p1 * 100;
p4 = p1 * taa;
p5 = 308.7 - 0.028 * mw + p2 * (tra / 100) ^ 4;
xn = tcla / 100;
xf = xn;
% Number of iterations
n = 0;
% Stop criterion
eps = 0.00015;
while true
	xf = (xf + xn) / 2;
	% Heat transfer coefficient by natural convection
	hcn = 2.38 * abs(100 * xf - taa) ^ 0.25;
	if hcf > hcn
		hc = hcf;
	else
		hc = hcn;
	end
	xn = (p5 + p4 * hc - p2 * xf ^ 4) / (100 + p3 * hc);
	n = n + 1;
	if n > 150
		pmv = NaN;
		ppd = 100;
		return
	end
	if abs(xn - xf) < eps
		break
	end
end
% Surface temperature of the clothing
tcl = 100 * xn - 273;

% Heat loss components
% Heat loss diff. through skin
hl1 = 3.05 * 0.001 * (5733 - 6.99 * mw - pa);
% Heat loss by sweating (comfort)
if mw > 58.15
	hl2 = 0.42 * (mw - 58.15);
else
	hl2 = 0;
end
% Latent respiration heat loss	
hl3 = 1.7 * 0.00001 * m * (5867 - pa);
% Dry respiration heat loss
hl4 = 0.0014 * m * (34 - ta);
% Heat loss by radiation
hl5 = 3.96 * fcl * (xn ^ 4 - (tra / 100) ^ 4);
% Heat loss by convection
hl6 = fcl * hc * (tcl - ta);

% PMV and PPD calculation
% Thermal sensation trans coefficient
ts = 0.303 * exp(-0.036 * m) + 0.028;
% Predicted Mean Vote
pmv = ts * (mw - hl1 - hl2 - hl3 - hl4 - hl5 - hl6);
% Predicted Percentage of Dissatisfied
ppd = 100 - 95 * exp(-0.03353 * pmv ^ 4 - 0.2179 * pmv ^ 2);
% Stay in the sensation scale
if pmv > 3
	pmv = 3;
elseif pmv < -3
	pmv = -3;
end
end