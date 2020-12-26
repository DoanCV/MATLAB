function plotMagnitude( f, signal, titleVar )
    
    plot( f, abs( signal ) );
    title( titleVar );
    xlabel( 'Frequency (Hz)' );
    ylabel( 'Magnitude' );
    
end