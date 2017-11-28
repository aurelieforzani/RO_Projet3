function x = strategie(numpart,tx,ty,gx,gy)

if (numpart == 2 && ty(1) >= 2.9)
    x = 0.0000000129;
elseif (ty(1) == 0 && ty(2) == 0 && numpart > 2)
    x = 1.5;
elseif (numpart > 2 && ty(numpart-1) > 2.8 && ty(numpart-2) > 2.8)
    x = 0;
elseif ( numpart > 2 && ty(numpart - 1) == 0)
    x = 1.5;
else
    x = 0.75;
end

end
