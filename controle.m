function x = strat_controle(numpart,tx,ty,gx,gy)


T = 9/7;
R = 9/8;
P = 1;
S = 9/10;

chi =6;
phi = 0.5 * (P-S)/((P-S)+chi*(T-P));
p1 = 1-phi*(chi-1)*(R-P)/(P-S);
p2 = 1-phi*(1+chi*(T-P)/(P-S));
p3 = phi*(chi+(T-P)/(P-S));
p4 = 0;

gentil = 1;

alea = rand;
if numpart == 1 
    x =0.75;
else
    for y = 1:(numpart - 1)
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
        x = 0.75
    elseif alea <p
        x = 0.75;
    else
        x= 1.25;
    end
    
    
   

end
end



