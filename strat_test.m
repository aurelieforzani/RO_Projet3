function x = strategie(numpart,tx,ty,gx,gy)
% strategie -- Strategie d'un joueur 
%
%  Usage
%    x = strategie(nx,ny,ng,tx,ty,gx,gy)
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
%  See also
%    jeu
%
%  References
%    "L'altruisme perfectionne", J.P. Delahaye, P. Mathieu,
%    Pour la science No 187, Mai 1993
%

 % joué 9/8 au premier tour, optimise y=0.75 et signature
if (numpart == 1)
    x= 9/8; 
else
    % joué coopératif au deuxieme tour si premier coup adverse non nul
    if ((numpart == 2) & (ty(1) ~= 0))
      x= 0.75;
    else
        % si premier coup adverse nul, et second égale 15/16 => non
        % coopératif, donc stackelberg
        if ((ty(1) == 0) & ty(2) == 15/16)
            x = strat_stackelberg(numpart,tx,ty,gx,gy)
        else
            % si premier coup adverse nul, et second égale 10/8 => 
            % stackelbereg, donc anti-stackelberg
            if ((ty(1) == 0) & ty(3) == 10/8)
                b = ty(numpart-1)/(3-tx(numpart-2));
                x = 1/(2-b) * (3-ty(numpart-1));
            else
                % Si premier coup adverse égale 9/8 (coup signature) =>
                % soi-même, donc coopération
                if (ty(1) == 9/8)
                    x = 0.75;
                else
                    % si second coup adverse coopère malgré notre trahison au
                    % pemier tour => coopératif, donc x=9/8 optimise y=0.75
                    if ((ty(2) == 0.75) & (ty(numpart-1)==0.75))
                        x = 9/8;
                    else
                        % trahison au dernier tour après coopération
                        if (numpart == size(tx,2) & ty(1) ~=0)
                            x = 9/8;
                        % joué notre stratégie toujours coopéré tant que non
                        % trahi
                        else
                            x = 0.75
                        end;
                    end;
                end;
            end;
        end;
    end;
end;

