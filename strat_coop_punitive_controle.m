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
d = 3;
if(numpart == 100)
    disp("On trahit � la fin ! :D");
    x = (d - d/4) / 2;
    return
end

if (numpart == 1)
    % par defaut, on coopere
	x= 0.75;
else
    %on punit la trahison
    if (ty(numpart-1)==0.75)
        x = 0.75;
    else        
        % On compte le nombre de fois où il nous a trahi pendant qu'on a
        % coopéré. SAUF si c'était la première tentative d'une reconciliation.

            % On calcule les indices des parties où l'on a coopéré
            indices_cooperation = find(tx(1:numpart-1) == 0.75);

            % On calcule les indices de nos r�demptions
            indices_redemptions = [];
            for i=3:numpart-1
                if(tx(i) == 0.75)
                    if(tx(i-1) ~= 0.75)
                        indices_redemptions = [indices_redemptions, i];
                    end
                end
            end
           % indices_redemptions
            
            % On compte le nombre de fois o� l'on a coop�rer avec
            % l'adversaire sans que ce soit une r�demption
            indices_cooperation_non_redemption = [];
            if(numpart >= 3)
                indices_cooperation_non_redemption = setdiff(indices_cooperation, indices_redemptions);
            end
            %indices_cooperation_non_redemption

            % On compte le nombre de fois où on a été trahi à part pendant les
            % phases de punition et de r�demption
            nb_trahisons_adverses = 0;
            for i=indices_cooperation_non_redemption
                if (ty(i) ~= 0.75)
                    nb_trahisons_adverses = nb_trahisons_adverses + 1;
                end
            end
           % nb_trahisons_adverses
            
            % On punit de plus en plus si on nous a souvent trahi
            % On calcule le nombre de fois o� l'on a d�j� puni
            nb_punitions_faites = 0;
            % On vérifie si on est en phase de punition
            if (numpart > 2 && tx(numpart - 1) ~= 0.75)
                % On est en phase de punition. On calcule combien de fois on a
                % déjà punit
                while(numpart - nb_punitions_faites >= 2 && tx(numpart - 1 - nb_punitions_faites) ~= 0.75)
                   nb_punitions_faites = nb_punitions_faites + 1;
                end
            end
            %nb_punitions_faites
            
            % On calcule le nombre de punitions restantes � faire
            nb_punitions_restantes = sum(1:nb_trahisons_adverses) - nb_punitions_faites;
            %nb_punitions_restantes = factorial(nb_trahisons_adverses) - nb_punitions_faites;
            
        % Si le nombre de punitions restantes est nul, alors on effectue
        % une REDEMPTION !
        if(nb_punitions_restantes == 0)
            x = 0.75;
            return
        % si a fait une rédemption au tour d'avant, on COOPERE une fois de
        % plus
        elseif (ismember(numpart - 1, indices_redemptions))
            x = 0.75;
            return
        
        % sinon on PUNIT !
        else
            x = controle(numpart, tx, ty, gx, gy);
            return
        end
        
    end
end;