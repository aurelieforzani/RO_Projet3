function x = strategie(numpart,tx,ty,gx,gy)

% On envoie notre signature au toutes stratégie hostile
if (numpart == 2 && ty(1) > 2.9)
    x = 0.0000000129;
% On se défend face à la stratégie vide
elseif (ty(1) == 0 && ty(2) == 0 && numpart > 2)
    x = 1.5;
% On se défend face à une stratégie hostile
elseif (numpart > 2 && ty(numpart) > 2.8 && ty(numpart-1) > 2.8)
    x = 0;
% On exploite notre stratégie esclave
elseif ( numpart > 2 && ty(numpart - 1) == 0)
    x = 1.5;
% Sinon on coopère
else
    x = 0.75;
end

end
