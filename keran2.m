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
%  Description
%    Elaboration d'une strategie dans le cadre de jeux iteres
%    avec information complete. L'ensemble des strategies est
%
%   Explication 
%   Etant à la recherche d'une stratégie comprimisant entre stackelberg(2/3)  
%   qui donne un nombre de victoires importants mais un nombre de
%   points pas satisfaisant et noncoopératif(1/2) qui donne un grand nombre de 
%   points mais qui n'est pas nécessairement conseillé. J'ai avancé par
%   dichotomie entre respectivement 2/3 et 1/2 je tombe sur une valeur
%   13/24 maximisant le nombre de points et ayant un nombre de victoire
%   entre celui du noncoopératif et du stackelberg.
%
%
%
%  See also
%    jeu
%
%  References
%    "L'altruisme perfectionne", J.P. Delahaye, P. Mathieu,
%    Pour la science No 187, Mai 1993
%

strat = probaChoix(numpart,tx,ty,gx,gy);
%disp(strat);



if (numpart == 1)
	x= 0.75;
else
    if strncmp(strat,'strat_cooperatif.m',16)  %strat == 1 %1
        %disp('coop');
        x = 0.75;
    elseif  strncmp(strat,'strat_keran.m',11) %strat == 2 %2
        %disp('keran');
        x = 2*(3-ty(numpart-1))/3;
    elseif strncmp(strat,'strat_noncooperatif.m',19) %strat == 4 %4
        %disp('noncoop');
        x = 2*(3-ty(numpart-1))/3;
    elseif strncmp(strat,'strat_stackelberg.m',17) %strat == 5 %5
        %disp('stack');
        x = 13*(3-ty(numpart-1))/24;
    elseif strncmp(strat,'strat_vide.m',10) %strat == 6 %6
        %disp('vide');
        x = 1*(3-ty(numpart-1))/2;
    else
        if (numpart <= 3)             
            disp('ker_jouer')
            x = 13*(3-ty(numpart-1))/24;
        else
            valeurPrevue = ty(find(min(abs(tx(1:numpart-2) - tx(numpart-1))) == abs(tx(1:numpart-2) - tx(numpart-1)))+1);
            valeurPrevue = valeurPrevue(1);
            x = (3-valeurPrevue)/2;
        end
    end
end