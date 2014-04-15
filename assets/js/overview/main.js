/*********************************
    JUST SETTING UP THE PAGE HERE
*********************************/
    // Initializes the bootstrap modals
    $('.modal#new-group').modal({
        show : false 
    });
    
    $('.modal#old-group').modal({ 
        show : false
    });

    // Proceed to execute and save the group
    $('.btn#save-new-group').on('click', handlerCreateGroup);

    // Proceed to update the group
    $('.btn#update-old-group').on('click', handlerUpdateGroup);

    // Proceed to execute and delete the group
    $('.btn#delete-old-group').on('click', handlerDeleteGroup);


/*********************************
    SAVING NEW GROUPS AND QUERIES
*********************************/
    // Brings up the modal for adding a new group
    $('.btn#add-new-group').click(function(){
        var product_tag = $(this).closest('div.product.row').attr('id');
        
        // Clean up modal from prior viewing of existing groups
        $('.modal#new-group').find('div.new-query').remove();
        $('.modal#new-group').find('.btn#save-new-group').data('product_tag', product_tag );
        $('.modal#new-group').modal('toggle');
    });

    // Append a new HTML query template for the group
    $('.btn#new-query-template').click( function() {
        var thisNum = uniqueid();
        $('.modal#new-group').find('form').append( templateNewGroup( thisNum ));

        // Initializing remove button for this new item
        $('button#remove-new-query').click(function(){
            $(this).closest('div.new-query').remove();
        });
        // Initializing colorpicker for this new item
        $(".colourpicker[id='"+thisNum+"']").spectrum({
            showInput: false,
            preferredFormat: 'hex6',
            clickoutFiresChange: true,
            showButtons: false,
            move: function(color) {
                $(".colourpicker[id='"+thisNum+"']").css( 'color', color.toHexString() );
            }
        });
        
        $('.quick-qb[id="'+thisNum+'"]').click(function(){
            var $this = $(this);
            quickQbmaker($this);
        });
    });


/*****************************************
    EDITING EXISTING GROUPS AND QUERIES
*****************************************/
    // Brings up the modal for adding a new group
    $('li#edit-old-group').click(function(){
        var groupID = $(this).data('group-id');
        var productTag = $(this).closest('div.product.row').attr('id');
        var thisGroup = coreData[productTag].groups[groupID];

        // Clean up modal from prior viewing of existing groups
        $('.modal#old-group').find('div.old-query').remove();

        // Setting the values inside the modal's form fields
        $('.modal#old-group').find('input#group-name').val( thisGroup.title );

        if ( thisGroup.is_plot ) {
            $('.modal#old-group').find('input#group-is-plot').prop( "checked", true );
        } else {
            $('.modal#old-group').find('input#group-is-plot').prop( "checked", false );
        }

        if ( thisGroup.is_number ) {
            $('.modal#old-group').find('input#group-is-number').prop( "checked", true );
        } else {
            $('.modal#old-group').find('input#group-is-number').prop( "checked", false );
        }
        
        $.each( thisGroup.queries, function( query_id, query ){
            // Append the html for each query
            $('.modal#old-group').find('form').append( templateOldGroup( query_id, query ) );
             // Initializing colorpicker for this new item
            $(".colourpicker[id='q"+query_id+"']").spectrum({
                showInput: false,
                preferredFormat: 'hex6',
                clickoutFiresChange: true,
                showButtons: false,
                move: function(color) {
                    $(".colourpicker[id='q"+query_id+"']").css( 'color', color.toHexString() );
                }
            });
        });

        $('.btn#delete-old-group').data('group-id', groupID);
        $('.btn#update-old-group').data('group-id', groupID );
        // End of setting values in the modal form

        // Fields are populated and disabled. Show modal.
        $('.modal#old-group').modal('toggle');
    });
    




