/***********************
    Page specific event triggers
***********************/
    // Initializing the datepicker
    $('input.datepicker').datepicker();

    // User has clicked on the button for getting the query in Qb format
    $('.btn#query-compile').click(function(){
        $this = $(this);
        $this.addClass('disabled');

        // Retrieve the specified URL
        bzURL = $('input#bz-url').val();
        
        console.log(bzURL);



        // Start building the Qb query with all our parameters
        var qbQuery = bzSearchToQb( bzURL, start, end, cluster );
        
    });

/*****************************
    Make life awesome - Helper functions
******************************/
    // Puts the output text inside the text box
    // Also gives it a nice green color that fades out after a while
    function showResult( text ){
        $('textarea.query-output').css( 'background', '#E5FFDD' );
        $('textarea.query-output').text( text );
        setTimeout(function() {
            $('textarea.query-output').css( 'background', '' );
        }, 1500);
    }
