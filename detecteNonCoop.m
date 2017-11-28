function noncoopere = detecteNonCoop(numpart,tx,ty,gx,gy)

% Inputs
%    tx     tableau des strategies jouees par le joueur x
%    ty     tableau des strategies jouees par le joueur y (l'adversaire)
%    gx     tableau des gains du joueur x
%    gy     tableau des gains du joueur y (l'adversaire)

% Output
%    coopere  bool qui vaut vrai si le mec d'en face coopere 5 fois
%    d'affilé

noncoopere = 1;

if (numpart < 8)
    noncoopere = 0;
else
   %tx(numpart-5:numpart-1)
   for i=1:5
    noncoopere = noncoopere && (ty(numpart-i) == (3-tx(numpart-i-1))/2);
   end
end

return
end 