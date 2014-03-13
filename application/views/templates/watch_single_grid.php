<?php /* Loads a view for a single grid, which could be sized either for a plot or number */ ?>
<li class="group<?= ($group['is_default'] ) ? ' is-default' : ''; ?>" id="g<?= $group_id; ?>" data-row="1" data-col="1" data-sizex="<?= ($type == 'make_plot')? 3 : min(2, count($group['queries'])); ?>" data-sizey="<?= ($type == 'make_plot')? 2 : 1; ?>">
    <?php /* Loads up the top menu and everything that should be in it */ ?>
    <div class="top-menu">
        <?php if ( !$group['is_default']  && $this->session->userdata('email') ) { ?>
            <?php /* Only administrators are allowed to see the group editing pencil */ ?>
            <button class="btn btn-xs pull-right" id="edit-old-group" title="Edit" data-group-id="<?= $group_id; ?>">
                <i class="fa fa-pencil fa-lg"></i>
            </button>
        <?php } ?>
        <?php /* Boilerplate for rules should be accessible to anyone who wishes to contribute a script */ ?>
        <button class="btn btn-xs pull-right" id="get-rule-boilerplate" title="Rules" data-group-id="<?= $group_id; ?>">
            <i class="fa fa-tachometer fa-lg"></i>
        </button>
        <?php foreach ( $group['queries'] as $query ) { ?>
            <?php /* Print a color coded bug link for every URL field that is not empty */ ?>
            <?php if ( !empty($query['bz_query']) ) { ?>
                <a class="btn btn-xs pull-right" href="<?= $query['bz_query']; ?>" target="_blank" title="<?= $query['title']; ?>" style="color:<?= $query['colour']; ?>;">
                    <i class="fa fa-bug fa-lg"></i>
                </a>
            <?php } ?>
        <?php } ?>
    </div>

    <?php if ( $type == 'make_plot' ) { ?>
        <?php /* Prints the containing box for the plot */ ?>
        <div class="group-graph" id="g<?= $group_id; ?>">
            <div class="y-axis" id="g<?= $group_id; ?>"></div>
            <div class="plot" id="g<?= $group_id; ?>"></div>
        </div>
    <?php } else if ( $type == 'make_number' ) { ?> 
        <?php /* Prints the containing box for the numbers */ ?>
        <div class="group-number text-center" id="g<?= $group_id; ?>">
            <?php foreach( $group['queries'] as $query_id => $query ) { ?>
                <?php /* Prints the containing sub-box for each individual number */ ?>
                <div class="text-center" id="q<?= $query_id; ?>" title="<?= $query['title']; ?>" style="width:<?= 90 / count($group['queries']); ?>%; display:inline-block;"></div>
            <?php } ?>
        </div>
    <?php } ?>
    <?php /* Every grid starts off as one that needs to be loading */ ?>
    <div class="text-center group-title" id="g<?= $group_id; ?>">
        <img class="load-status" src="/assets/img/mozchomp.gif">
        <h4><?= $group['title']; ?></h4>
    </div>
</li>