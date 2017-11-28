function x = strat_controle(numpart,tx,ty,gx,gy)
% Fonction qui applique la stratégie du déterminant nul dans le cadre du duopole de Cournot.
%
%% DONNEES
% numpart : int, numéro de la partie courante
% tx : float[100], contient tous les coups joués par nous
% ty : float[100], contient tous les coups joués par l'autre joueur
% gx : float[100], contient tous nos gains à chaque tour
% gy : float[100], contient tous les gains de l'adversaire à chaque tour
%
%% SORTIE
% x : float, coup que l'on va jouer au tour numpart
%
%% VARIABLES LOCALES
% T : 	float,  gain si on trahit et que l'autre joueur coopère
% R : 	float,  gain de chaque joueur si les deux joueurs coopèrent
% S : 	float,  gain si on coopère et que l'autre trahit
% P : 	float,  gain de chaque joueur si les deux joueurs trahissent.
% chi : float, facteur d'extorsion
% phi : float, phi défini dans le rapport
% p1 : 	float, probabilité de coopérer si les deux joueurs ont coopéré au tour précédent
% p2 : 	float, probabilité de coopérer si on a coopéré et que l'adversaire a trahit
% p3 : 	float, probabilité de coopérer si on a trahit et que l'adversaire a coopéré
% p4 : 	float, probabilité de coopérer si les deux joueurs ont trahit au tour précédent.
% gentil : boolean : true si l'autre joueur a toujours coopéré, false sinon
%
%% DEBUT DU PROGRAMME

%Définition des gains selon ce que l'on joue et ce que l'autre joueur joue
T = 9/7;
R = 9/8;
P = 9/12.5;
S = 9/10;

% Définition des probabilités de coopérer au prochain tour ou de trahir
chi =6;
phi = 0.5 * (P-S)/((P-S)+chi*(T-P));
p1 = 1-phi*(chi-1)*(R-P)/(P-S);
p2 = 1-phi*(1+chi*(T-P)/(P-S));
p3 = phi*(chi+(T-P)/(P-S));
p4 = 0;

% Permet d'être coopératif par défaut
gentil = 1;

% Permet de tester les probabilités définies plus haut
alea = rand;

%Si le joueur adverse a toujours coopérer, on coopère aussi 
if  numpart == 1 
    x =0.75;
else
    for y = 1:(numpart - 1)
        gentil = gentil && (ty(y) == 0.75);
    end
    
    % Sinon on appplique la stratégie selon les probabilités définies 
    % et ce qui a été joué au tour précédent
    if (ty(numpart-1) ~= 0.75) && (tx(numpart-1) ~= 0.75)
        p = p4;
    elseif (ty(numpart - 1) ~= 0.75) && (tx(numpart -1) == 0.75)
        p = p2;
    elseif ty(numpart - 1) == 0.75 && tx(numpart-1) ~= 0.75
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
end



