<?php // if ( ! defined('BASEPATH')) exit('No direct script access allowed');
require(APPPATH.'/libraries/REST_Controller.php');

class Comments extends REST_Controller {
    
    function __construct() {
        parent::__construct();
        // Autoloaded Config, Helpers, Models
    }

    // Used to create a new group in the DB
    public function index_post() {
        $data = $this->post();
        
        if ( isset($data['version_id']) && isset($data['version_comment']) ){
            if ( $this->session->userdata('email') !==  false ) {
                $version_id = $data['version_id'];
                $comment    = $data['version_comment']; 

                $availability = $this->comment->retrieve( 
                    array(
                        'version_id' => $version_id
                    ) 
                ); 
                
                if ( count($availability) > 0 ) {
                    // Version already has a comment. Do update
                    $this->comment->update( 
                        array(
                            'version_id' => $version_id
                        ),
                        array(
                            'comment_message' => $comment,
                            'comment_email' => $this->session->userdata('email'),
                            'last_updated' => null
                        )  
                    );
                    echo 'OK';
                } else {
                    // Version does not have a comment yet. Do insert
                    $new_comment = array( 
                        'version_id' => $version_id,
                        'comment_message' => $comment,
                        'comment_email' => $this->session->userdata('email')  
                    );
                    
                    $comment_id = $this->comment->create( $new_comment );
                    echo 'OK';
                }
            } else {
                log_message('error', 'Unauthorized access attempted in /api/comments.php');
                echo "Unauthorized attempt to post comment";
            }   
        } else {
            log_message('error', 'Missing version_id or comment parameters in /api/comments.php/index_post');
            echo 'Missing version_id or comment parameters.';
        }

        return;
    }
}