function [y, cons] = TP_Baksan_R_objfun(x)
%*************************************************************************
% Objective function : Maxwell ANSYS
%*************************************************************************
y = [0,0];
cons = [];

mass = evalin('base', 'RandomForestBaksanMass');
losses = evalin('base', 'RandomForestBaksanLosses'); 
current = evalin('base', 'RandomForestBaksanCurrent'); 

y(1) = predict(mass, x);		% stator mass
y(2) = predict(losses, x); 	% total losses
y(3) = predict(current, x);	% rotor current

