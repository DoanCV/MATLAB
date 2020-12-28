function out = srconvert( in )

    totalMult = 0;
    totalAdd = 0;
    [out, totalMult, totalAdd] = filterUp( in, 5, totalMult, totalAdd );
    [out, totalMult, totalAdd] = filterUp( out, 2, totalMult, totalAdd ); 
    out = 7*downsample(out,7);
    [out, totalMult, totalAdd] = filterUp( out, 2, totalMult, totalAdd );
    [out, totalMult, totalAdd] = filterUp( out, 2, totalMult, totalAdd );

    [out, totalMult, totalAdd] = filterUp( out, 2,totalMult,totalAdd );
    out = 7*downsample(out,7);
    [ out, totalMult, totalAdd ] = filterUp( out, 2, totalMult, totalAdd );
    [ out, totalMult, totalAdd ] = filterUp( out, 2, totalMult, totalAdd );
   
    out = 3*downsample(out,3);
    out = out./max( abs(out) );
    disp( "Total Multiplications: " + totalMult );
    disp( "Total Additions: " + totalAdd );
    disp( "Hand calculation:  1357 multiplication and 1350 additions." );
    
end
