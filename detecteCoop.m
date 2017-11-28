function coopere = detecteCoop(numpart,tx,ty,gx,gy)

% Inputs
%    tx     tableau des strategies jouees par le joueur x
%    ty     tableau des strategies jouees par le joueur y (l'adversaire)
%    gx     tableau des gains du joueur x
%    gy     tableau des gains du joueur y (l'adversaire)

% Output
%    coopere  bool qui vaut vrai si le mec d'en face coopere 5 fois
%    d'affilé

if (numpart < 7)
    coopere = 0;
else
   %tx(numpart-5:numpart-1)
   coopere = (ty(numpart-5:numpart-1) == [0.75,0.75,0.75,0.75,0.75]);
end

return
end 