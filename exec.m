disp('Duopole de Cournot');
disp('Stratégies possibles : cooperatif/noncooperatif/stackelberg/star2016');
NBJ=input('Nombre de parties: ');
strax=input('Stratégie du 1er joueur: ','s');
stray=input('Stratégie du second joueur: ','s');
[tx, ty, gx, gy] = jeu(NBJ,strax,stray);
fig = afficher(tx,ty,gx,gy,strax,stray);
sum(gx)
sum(gy)

