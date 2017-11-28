function x = strategie(numpart,tx,ty,gx,gy)
% strategie -- Strategie d'un joueur 
%
%  Usage
%    x = strategie(nx,ny,ng,tx,ty,gx,gy)
%
%  Inputs
%    tx     tableau des strategies jouees par le joueur x
%    ty     tableau des strategies jouees par le joueur y (l'adversaire)
%    gx     tableau des gains du joueur x
%    gy     tableau des gains du joueur y (l'adversaire)
%
%  Outputs
%    x      strategie elaboree par le joueur x
%
%  Description
%    Elaboration d'une strategie dans le cadre de jeux iteres
%    avec information complete. L'ensemble des strategies est
%
%  See also
%    jeu
%
%  References
%    "L'altruisme perfectionne", J.P. Delahaye, P. Mathieu,
%    Pour la science No 187, Mai 1993
%

 % joué  y=0.75 au premier tour
if (numpart == 1)
    x= 0.75; 
% joué coopératif au deuxieme tour si premier coup adverse non nul
elseif ((numpart == 2) & (ty(1) ~= 0))
    x= 0.75;
% si premier coup adverse nul, et second égale 9/8 => non
% coopératif, donc stackelberg
elseif ((ty(1) == 0) & ty(2) == 9/8)
    x = strat_stackelberg(numpart,tx,ty,gx,gy);
% si premier coup adverse nul, et second égale 6/4 => 
% stackelbereg, donc anti-stackelberg
elseif ((ty(1) == 0) & (ty(2) == 2*(3-tx(1))/3) & numpart>2)
    b = ty(numpart-1)/(3-tx(numpart-2));
    x = 1/(2-b) * (3-ty(numpart-1));
% Si deux premiers coup adverse égale 0 =>
% vide, donc d/2=1.5
elseif ((ty(1) == 0) & (ty(2) == 0))
    x = 1.5;
% Si adversaire joue 3, punisher donc 0
elseif (ty(numpart-1)>=3)
    x = 0;
% trahison au dernier tour après coopération
elseif (numpart == size(tx,2) & ty(1) ~=0)
    x = 9/8;
% joué notre stratégie toujours coopéré tant que non
% trahi, sinon coop_punitive_controle
else
    x = 0.75;
end;


