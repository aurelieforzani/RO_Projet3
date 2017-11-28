function [affine,bAJouer] = detecteAffine(numpart,tx,ty,gx,gy)

% Inputs
%    tx     tableau des strategies jouees par le joueur x
%    ty     tableau des strategies jouees par le joueur y (l'adversaire)
%    gx     tableau des gains du joueur x
%    gy     tableau des gains du joueur y (l'adversaire)

% Output
%    coopere  bool qui vaut vrai si le mec d'en face coopere 5 fois
%    d'affilé

b = [0,0,0,0,0];
affine = 1;

if (numpart < 8)
    affine = 0;
else
   %tx(numpart-5:numpart-1)
   for i=1:5
       %Calcul de b
       b(i) = ty(numpart-1)/(3-tx(numpart-2));
   end
   for i=1:5
      affine = affine && (b(1) == b(i)) ;
   end
end

bAJouer = b(1);

return
end 