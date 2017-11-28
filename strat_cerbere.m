function x = strategie(numpart,tx,ty,gx,gy)
% strategie -- Strategie d'un joueur 
%
%  Usage
%    x = strategie(numpart,tx,ty,gx,gy)
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
% stratégie élaborée pour punir un joueur non coopératif

% On renvoie toujours le pire pour nos adversaire !
% Sans se soucier de nos propre points
x = rand*0.1 + 2.9;

% Si on a reçu un signal de notre maître
if(ty(2) == 0.0000000129) 
    x = 0;
end

return