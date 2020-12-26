function plotPhase( f, signal, titleVar )

    plot( f,( angle( signal ) ) );
    title( titleVar );
    xlabel( 'Frequency (Hz)' );
    ylabel( 'Phase' );
    
end