function numStart = probaChoix(numpart,tx,ty,gx,gy) 
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
%    x      strategie elaboree par le joueur 
%


%récupération des strategies possibles pour l'adversaire
listenomindir = dir('strat_*');
listenoms = char({listenomindir.name});
 %disp('Liste de strategies a tester (fichiers debutant par "strat_")');
%disp(listenoms);

%anticipation des gains
[size1 , ~] = size(listenoms);
gains = zeros(1,size1);

for i=1:size1
    [~, nomx , ~] = fileparts(listenoms(i,:));
    if not(strcmp(nomx,'strat_keran2') || strcmp(nomx,'strat_agressive')|| strcmp(nomx,'strat_finale') || strcmp(nomx,'strat_star2016'))
        tx_ = tx(end) ;
        ty_ = feval(nomx,numpart,ty,tx,gy,gx) ;
        [~, gains(i)] = gain(tx_,ty_) ;
    end
    
end
[M,I] = max(gains);
%disp(gains);
%disp(M);
%disp(I);
numStart = listenoms(I,:); %I
%disp(listenoms(I,:));
%disp(numStart);
end