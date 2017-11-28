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
d = 3;

T = 5/4;
R = 9/8;
P = 0.5;
S = 0;

chi =6;
phi = 0.5 * (P-S)/((P-S)+chi*(T-P));
p1 = 1-phi*(chi-1)*(R-P)/(P-S);
p2 = 1-phi*(1+chi*(T-P)/(P-S));
p3 = phi*(chi+(T-P)/(P-S));
p4 = 0;

gentil = 1;

alea = rand;
if  numpart == 1 
    x =0.75;
else
    for y = 2:(numpart - 1)
        gentil = gentil && (ty(y) == 0.75);
    end
    if ty(numpart-1) >0.8 && tx(numpart-1) >0.8
        p = p4;
    elseif (ty(numpart - 1) > 0.8) && (tx(numpart -1) <= 0.8)
        p = p2;
    elseif ty(numpart - 1) <= 0.8 && tx(numpart-1) > 0.8
        p = p3;
    else
        p = p1;
    end
        

        
    if gentil
        x = 0.75;
    elseif alea <p
        x = 0.75;
    else
        x= 1.25;
    end
    
    
   

end

if (numpart > 5)
    %si repère une strategie cooperative
    if (all (ty(2:numpart-1) == 0.75))
        %traïr définitivement
        x = (d - 0.75) / 2;
    else
        %si on repère une stratégie noncoopérative
        b = zeros(1,numpart-2);
        for j=2:(numpart-1)
            b(j-1) = (d - tx(j))/2;
        end;

        if (b(1:numpart-3) == ty(3:numpart-1))
            %jouer la strategie de Stackelberg
            x = 2/3 * (d- ty(numpart-1));
        end;

        %si on repère une stratégie affine
        b = zeros(1,numpart-3);
        for j=3:(numpart-1)
            b(j-2) = ty(j) / (d - tx(j-1));
        end;

        res = (b(3:numpart-3) - b(2));
        if (res < 10e-10)
            %adopter la strategie affine suivante 
            x = (d - ty(numpart-1))/(2-b(1));
        end;
    end;
end;