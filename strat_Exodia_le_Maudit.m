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

% Si notre adversaire ne fait que des 0, c'est la stratégie vide
if(numpart >= 2 && all(ty == 0))
    % on l'exploite donc
    x = d / 2;
    return
end

% On trahit à la fin si l'adversaire était en train de coopérer
if(numpart == 100 && ty(99) == 0.75)
    x = (d - d/4) / 2;
    return
end

% On envoie un signal à notre sbire
if(numpart == 2 && ty(1) >= 2.9)
    x = 0.0000000129;
    return
end

% Si on a détecté notre sbire, on l'exploite
if(numpart > 3 && all(ty(3:numpart-1)) == 0)
    x = d/2;
    return
end


% % Si on a détecté la stratégie non cooperative, on joue stackelberg
noncoop = true;
for i = 3:numpart
    if (ty(i-1) ~= (3-tx(i-2))/2)
        noncoop = false;
    end
end

 if ((ty(1) == 0) && numpart >= 3 && noncoop)
     x = strat_stackelberg(numpart,tx,ty,gx,gy);
     return
 end
 
% % Si on a détecté la stratégie stackelberg, on joue anti-stackelberg
stack = true;
for i = 3:numpart
    if (ty(i-1) ~= 2*(3-tx(i-2))/3)
        stack = false;
    end
end

  if ((ty(1) == 0) && numpart >= 3 && stack)
      b = ty(numpart-1)/(3-tx(numpart-2));
      x = 1/(2-b) * (3-ty(numpart-1));
      return
  end

% Si on détecte une stratégie sbire adverse, on se défend comme on peut ...
% (au deuxième coup on a envoyé le signal de toute façon)
 if(numpart >= 3 && all(ty(1:numpart-1) >= 2.5))
     x = 0;
     return
 end
% On a fini les particulartiés ...


%% On peut passer à l'algorithme général !
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
            indices_redemptions;
            
            % On compte le nombre de fois o� l'on a coop�rer avec
            % l'adversaire sans que ce soit une r�demption
            indices_cooperation_non_redemption = [];
            if(numpart >= 3)
                indices_cooperation_non_redemption = setdiff(indices_cooperation, indices_redemptions);
            end
            indices_cooperation_non_redemption;

            % On compte le nombre de fois où on a été trahi à part pendant les
            % phases de punition et de r�demption
            nb_trahisons_adverses = 0;
            for i=indices_cooperation_non_redemption
                if (ty(i) ~= 0.75)
                    nb_trahisons_adverses = nb_trahisons_adverses + 1;
                end
            end
            nb_trahisons_adverses;
            
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
            nb_punitions_faites;
            
            % On calcule le nombre de punitions restantes � faire
            nb_punitions_a_faire = sum(1:nb_trahisons_adverses);
            nb_punitions_restantes = nb_punitions_a_faire - nb_punitions_faites;
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
            x = strat_controle(numpart, tx, ty, gx, gy);
            return
        end
        
    end
end;
