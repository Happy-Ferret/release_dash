CREATE TABLE `administrator` (
    `id` int(11) not null auto_increment,
    `email` varchar(255) not null,
    `last_updated` timestamp default current_timestamp on update current_timestamp,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE `product` (
    `id` int(11) not null auto_increment,
    `tag` varchar(255) not null,   
    `title` varchar(255) not null,
    `last_updated` timestamp default current_timestamp on update current_timestamp,
    UNIQUE (`tag`),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE `version` (
    `id` int(11) not null auto_increment,
    `tag` varchar(255) not null,
    `title` varchar(255) not null,
    `product_id` int(11) not null,
    `last_updated` timestamp default current_timestamp on update current_timestamp,
    UNIQUE (`product_id`, `tag`),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE `channel` (
    `id` int(11) not null auto_increment,
    `tag` varchar(255) not null,
    `title` varchar(255) not null,
    `product_id` int(11) not null,
    `next_channel` int(11) not null default '0',
    `is_first` tinyint(4) not null default '0',
    `last_updated` timestamp default current_timestamp on update current_timestamp,
    UNIQUE (`product_id`, `tag`),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE `cycle` (
    `id` int(11) not null auto_increment,
    `start` datetime not null,   
    `end` datetime not null,
    `last_updated` timestamp default current_timestamp on update current_timestamp,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE `version_channel_cycle` (
    `id` int(11) not null auto_increment,
    `version_id` int(11) not null,
    `channel_id` int(11) not null,
    `cycle_id` int(11) not null,
    `last_updated` timestamp default current_timestamp on update current_timestamp,
    UNIQUE (`version_id`, `channel_id`, `cycle_id`),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE `group` (
    `id` int(11) not null auto_increment,
    `title` varchar(255) not null,
    `entity` varchar(255) not null,
    `entity_id` int(11) not null,
    `is_plot` tinyint(4) not null default '0',
    `is_number` tinyint(4) not null default '0',
    `last_updated` timestamp default current_timestamp on update current_timestamp,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE `query` (
    `id` int(11) not null auto_increment,
    `title` varchar(255) not null,
    `group_id` int(11) not null,
    `query_qb` text,
    `query_bz` text,
    `references` varchar(255),
    `colour` varchar(255),
    `last_updated` timestamp default current_timestamp on update current_timestamp,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE `score` (
    `id` int(11) not null auto_increment,
    `version_id` int(11) not null,
    `score_colour` varchar(255),
    `last_updated` timestamp default current_timestamp on update current_timestamp,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

INSERT INTO `administrator` (`id`, `email`) VALUES 
('1', 'wcheong@mozilla.com'     ),
('2', 'bbajaj@mozilla.com'      ),
('3', 'lsblakk@mozilla.com'     ),
('4', 'praghunath@mozilla.com'  ),
('5', 'sledru@mozilla.com'      );

INSERT INTO `product` (`id`, `tag`, `title`) VALUES 
('1', 'firefox', 'Firefox'),
('2', 'fennec', 'Firefox for Android'),
('3', 'b2g', 'Firefox OS');

INSERT INTO `version` (`id`, `tag`, `title`, `product_id`) VALUES
('1',  '25',   'Firefox 25',                '1'),
('2',  '26',   'Firefox 26',                '1'),
('3',  '27',   'Firefox 27',                '1'),
('4',  '28',   'Firefox 28',                '1'),
('5',  '29',   'Firefox 29',                '1'),
('6',  '25',   'Firefox for Android 25',    '2'),
('7',  '26',   'Firefox for Android 26',    '2'),
('8',  '27',   'Firefox for Android 27',    '2'),
('9',  '28',   'Firefox for Android 28',    '2'),
('10', '29',   'Firefox for Android 29',    '2'),
('11', '1_2',  'Firefox OS 1_2',            '3'),
('12', '1_3',  'Firefox OS 1_3',            '3'),
('13', '30',   'Firefox 30',                '1'),
('14', '30',   'Firefox for Android 30',    '2'),
('15', '1_4',  'Firefox OS 1_4',            '3');

INSERT INTO `channel` (`id`, `tag`, `title`, `product_id`, `next_channel`, `is_first`) VALUES
('1',  'central',         'Central',          '1', '2' , '1'),
('2',  'aurora',          'Aurora',           '1', '3' , '0'),
('3',  'beta',            'Beta',             '1', '4' , '0'),
('4',  'release',         'Release',          '1', '0' , '0'),
('5',  'central',         'Central',          '2', '6' , '1'),
('6',  'aurora',          'Aurora',           '2', '7' , '0'),
('7',  'beta',            'Beta',             '2', '8' , '0'),
('8',  'release',         'Release',          '2', '0' , '0'),
('9',  'development',     'Development',      '3', '10', '1'),
('10', 'stabilization',   'Stabilization',    '3', '0' , '0');

INSERT INTO `cycle` (`id`, `start`, `end`) VALUES
('1', '2013-06-25 00:00:00', '2013-08-06 00:00:00'),
('2', '2013-08-06 00:00:00', '2013-09-17 00:00:00'),
('3', '2013-09-17 00:00:00', '2013-10-29 00:00:00'),
('4', '2013-10-29 00:00:00', '2013-12-10 00:00:00'),
('5', '2013-12-10 00:00:00', '2014-02-04 00:00:00'),
('6', '2014-02-04 00:00:00', '2014-03-18 00:00:00');

INSERT INTO `version_channel_cycle` (`version_id`, `channel_id`, `cycle_id`) VALUES
('1', '1', '1'), ('1', '2', '2'), ('1', '3', '3'), ('1', '4', '4'), 
('2', '1', '2'), ('2', '2', '3'), ('2', '3', '4'), ('2', '4', '5'), 
('3', '1', '3'), ('3', '2', '4'), ('3', '3', '5'), ('3', '4', '6'),
('4', '1', '4'), ('4', '2', '5'), ('4', '3', '6'),
('5', '1', '5'), ('5', '2', '6'),
('13','1', '6'),
('6', '5', '1'), ('6', '6', '2'), ('6', '7', '3'), ('6', '8', '4'),
('7', '5', '2'), ('7', '6', '3'), ('7', '7', '4'), ('7', '8', '5'),
('8', '5', '3'), ('8', '6', '4'), ('8', '7', '5'), ('8', '8', '6'),
('9', '5', '4'), ('9', '6', '5'), ('9', '7', '6'),
('10','5', '5'), ('10','6', '6'),
('14','5', '6'),
('11','9', '2'), ('11','9', '3'), ('11','10','4'), ('11','10','5'),
('12','9', '4'), ('12','9', '5'), ('12','10','6'),
('15','9', '6');

INSERT INTO `group` (`id`, `title`, `entity`, `entity_id`, `is_plot`, `is_number`) VALUES
('1', 'Tracked vs Fixed',               'product', '1', '1', '0'),
('2', 'Unresolved',                     'product', '1', '1', '0'),
('3', 'Crashers',                       'product', '1', '1', '0'),
('4', 'Regressions',                    'product', '1', '1', '0'),
('5', 'Nominations(Default)',                    'product', '3', '1', '0'),
('6', 'Blockers(Default)',                       'product', '3', '1', '0'),
('7', 'Blocking Regressions for 1.4',   'version', '15','1', '0'),
('8', 'Nominated Bugs for 1.4',  'version', '15','1', '0');

INSERT INTO `query` (`id`, `title`, `group_id`, `colour`, `references`, `query_qb`, `query_bz`) VALUES
('1', '# Bugs tracking <version_title>',                 '1', 'rgb(194, 127, 127)', '',
    '{"from": "public_bugs","select": {"name": "num","value": "bug_id","aggregate": "count"},"esfilter": {"and": [{"term": {"cf_tracking_firefox<version_tag>": "+"}}]},"edges": [{"range": {"min": "modified_ts","max": "expires_on"},"domain": {"type": "date","min": @birthday,"max": @timestamp,"interval": "day"}}]}',
    'https://bugzilla.mozilla.org/buglist.cgi?f1=cf_tracking_firefox<version_tag>&list_id=9418681&o1=equals&query_format=advanced&v1=%2B' ),

('2', '# Fixed Bugs tracking <version_title>',           '1', 'rgb(108, 10, 238)', '',
    '{"from": "public_bugs","select": {"name": "num","value": "bug_id","aggregate": "count"},"esfilter": {"and": [{"term": {"cf_tracking_firefox<version_tag>": "+"}},{"term": {"cf_status_firefox<version_tag>": "fixed"}}]},"edges": [{"range": {"min": "modified_ts","max": "expires_on"},"domain": {"type": "date","min": @birthday,"max": @timestamp,"interval": "day"}}]}',
    'https://bugzilla.mozilla.org/buglist.cgi?f1=cf_tracking_firefox<version_tag>&list_id=9418686&o1=equals&o2=equals&query_format=advanced&f2=cf_status_firefox<version_tag>&v1=%2B&v2=fixed' ),

('3', '# Unresolved Bugs tracking <version_title>',      '2', 'rgb(51, 51, 51)', '',
    '{"from": "public_bugs","select": {"name": "num","value": "bug_id","aggregate": "count"},"esfilter": {"and": [{"term": {"cf_tracking_firefox<version_tag>": "+"}},{"or": [{"missing":{"field": "cf_status_firefox<version_tag>"}},{"not": {"terms": {"cf_status_firefox<version_tag>": ["wontfix","fixed","unaffected","verified","disabled","verified disabled"]}}}]}]},"edges": [{"range": {"min": "modified_ts","max": "expires_on"},"domain": {"type": "date","min": @birthday,"max": @timestamp,"interval": "day"}}]}',
    'https://bugzilla.mozilla.org/buglist.cgi?o5=notequals&v11=unaffected&j10=OR&o14=notequals&f13=OP&o2=equals&j16=OR&v5=wontfix&f12=CP&j4=OR&f14=cf_status_firefox<version_tag>&o17=notequals&o20=notequals&v2=%2B&f21=CP&known_name=Tracking<version_tag>%2B&f10=OP&f19=OP&f29=CP&f1=OP&f20=cf_status_firefox<version_tag>&j13=OR&f8=cf_status_firefox<version_tag>&f0=OP&j19=OR&o11=notequals&f18=CP&columnlist=bug_severity,priority,op_sys,assigned_to,bug_status,resolution,short_desc,changeddate,cf_tracking_firefox17,cf_tracking_firefox18,cf_status_firefox17,cf_status_firefox18&f15=CP&query_based_on=Tracking<version_tag>%2B&f9=CP&j7=OR&v20=verified%20disabled&f4=OP&query_format=advanced&j1=OR&v17=disabled&f3=CP&f2=cf_tracking_firefox<version_tag>&f11=cf_status_firefox<version_tag>&f5=cf_status_firefox<version_tag>&f17=cf_status_firefox<version_tag>&v8=fixed&v14=verified&f6=CP&f7=OP&o8=notequals&f16=OP&list_id=9407229' ),

('4', '# Crashers on <version_title>',                   '3', 'rgb(51, 51, 51)', '',
    '{"from": "public_bugs","select": {"name": "num","value": "bug_id","aggregate": "count"},"esfilter": {"and": [{"term": {"cf_tracking_firefox<version_tag>": "+"}},{"or": [{"term": {"keywords": "crash"}},{"prefix": {"keywords": "topcrash"}}]}]},"edges": [{"range": {"min": "modified_ts","max": "expires_on"},"domain": {"type": "date","min": @birthday,"max": @timestamp,"interval": "day"}}]}',
    'https://bugzilla.mozilla.org/buglist.cgi?v4=crash%2Ctopcrash&f1=cf_tracking_firefox<version_tag>&list_id=9577950&o1=equals&f4=keywords&query_format=advanced&f3=OP&o4=anywords&j3=OR&v1=%2B' ),

('5', '# Regressions on <version_title>',                '4', 'rgb(51, 51, 51)', '',
    '{"from": "public_bugs","select": {"name": "num","value": "bug_id","aggregate": "count"},"esfilter": {"and": [{"terms": {"bug_status": ["unconfirmed","new","assigned","reopened"]}},{"and": [{"and": [{"or": [{"term": {"cf_tracking_firefox<version_tag>": "+"}}]},{"or": [{"not": {"term": {"cf_status_firefox<version_tag>": "wontfix"}}}]},{"or": [{"not": {"term": {"cf_status_firefox<version_tag>": "fixed"}}}]},{"or": [{"not": {"term": {"cf_status_firefox<version_tag>": "unaffected"}}}]},{"or": [{"not": {"term": {"cf_status_firefox<version_tag>": "verified"}}}]},{"or": [{"not": {"term": {"cf_status_firefox<version_tag>": "disabled"}}}]},{"or": [{"not": {"term": {"cf_status_firefox<version_tag>": "verified disabled"}}}]}]},{"not": {"term": {"cf_status_firefox<version_tag-1>": "wontfix"}}},{"not": {"term": {"cf_status_firefox<version_tag-1>": "affected"}}}]}]},"edges": [{"range": {"min": "modified_ts","max": "expires_on"},"domain": {"type": "date","min": @birthday,"max": @timestamp,"interval": "day"}}]}',
    'https://bugzilla.mozilla.org/buglist.cgi?o5=notequals&v11=unaffected&j10=OR&o14=notequals&f13=OP&o2=equals&j16=OR&f23=cf_status_firefox<version_tag-1>&v5=wontfix&f12=CP&v24=affected&j4=OR&f14=cf_status_firefox<version_tag>&o17=notequals&o20=notequals&f24=cf_status_firefox<version_tag-1>&v2=%2B&f21=CP&known_name=Tracking<version_tag>%2B&f10=OP&f19=OP&f22=CP&f1=OP&f20=cf_status_firefox<version_tag>&j13=OR&f8=cf_status_firefox<version_tag>&f0=OP&j19=OR&o11=notequals&o24=notequals&f18=CP&columnlist=bug_severity%2Cpriority%2Cop_sys%2Cassigned_to%2Cbug_status%2Cresolution%2Cshort_desc%2Cchangeddate%2Ccf_status_firefox21%2Ccf_status_firefox<version_tag>&f15=CP&query_based_on=Tracking<version_tag>%2B&f9=CP&j7=OR&v20=verified%20disabled&f4=OP&o23=notequals&query_format=advanced&v23=wontfix&j1=OR&v17=disabled&f3=CP&f2=cf_tracking_firefox<version_tag>&f11=cf_status_firefox<version_tag>&bug_status=UNCONFIRMED&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&f5=cf_status_firefox<version_tag>&f17=cf_status_firefox<version_tag>&v8=fixed&v14=verified&f6=CP&f7=OP&o8=notequals&f16=OP&list_id=9686493' ),

('6', '# Nominations on <version_title:.>',              '5', 'rgb(51, 51, 51)', '',
    '{"from": "public_bugs","select": {"name": "num","value": "bug_id","aggregate": "count"},"esfilter": {"and": [{"term": {"cf_blocking_b2g": "<version_tag:.>?"}},{"terms": {"bug_status": ["unconfirmed","new","assigned","reopened","resolved","verified","closed"]}}]},"edges": [{"range": {"min": "modified_ts","max": "expires_on"},"domain": {"type": "date","min": @birthday,"max": @timestamp,"interval": "day"}}]}',
    'https://bugzilla.mozilla.org/buglist.cgi?j_top=OR&f1=cf_blocking_b2g&o1=equals&query_format=advanced&bug_status=UNCONFIRMED&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&bug_status=RESOLVED&bug_status=VERIFIED&bug_status=CLOSED&v1=<version_tag:.>%3F&list_id=9613973' ),

('7', '# Blockers on <version_title:.>',                 '6', 'rgb(194, 127, 127)', '',
    '{"from": "public_bugs","select": {"name": "num","value": "bug_id","aggregate": "count"},"esfilter": {"and": [{"term": {"cf_blocking_b2g": "<version_tag:.>+"}},{"terms": {"bug_status": ["unconfirmed","new","assigned","reopened"]}}]},"edges": [{"range": {"min": "modified_ts","max": "expires_on"},"domain": {"type": "date","min": @birthday,"max": @timestamp,"interval": "day"}}]}',
    'https://bugzilla.mozilla.org/buglist.cgi?j_top=OR&f1=cf_blocking_b2g&o1=equals&query_format=advanced&bug_status=UNCONFIRMED&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&v1=<version_tag:.>%2B&list_id=9613974' ),


('8', '# Blocking Regressions',                          '6', 'rgb(108, 10, 238)', '',
    '{"from": "public_bugs","select": {"name": "num","value": "bug_id","aggregate": "count"},"esfilter": {"and": [{"terms": {"bug_status": ["unconfirmed","new","assigned","reopened"]}},{"and": [{"regexp": {"keywords": "(regression)+"}}]},{"or": [{"term": {"cf_blocking_b2g": "<version_tag:.>+"}}]}]},"edges": [{"range": {"min": "modified_ts","max": "expires_on"},"domain": {"type": "date","min": @birthday,"max": @timestamp,"interval": "day"}}]}',
    'https://bugzilla.mozilla.org/buglist.cgi?j_top=OR&keywords=regression%2C%20&keywords_type=allwords&o1=equals&v1=<version_tag:.>%2B&f1=cf_blocking_b2g&query_format=advanced&bug_status=UNCONFIRMED&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&list_id=9753592' ),


('9', '# Blocking Regressions',                          '7', 'rgb(51, 51, 51)', '',
    '{"from": "public_bugs","select": {"name": "num","value": "bug_id","aggregate": "count"},"esfilter": {"and": [{"terms": {"bug_status": ["new","assigned","reopened","resolved","verified","closed"]}},{"terms": {"resolution": ["fixed","wontfix"]}},{"or": [{"regexp": {"keywords": "(regression)+"}}]},{"or": [{"or": [{"term": {"cf_blocking_b2g": "<version_tag:.>+"}}]}]}]},"edges": [{"range": {"min": "modified_ts","max": "expires_on"},"domain": {"type": "date","min": @birthday,"max": @timestamp,"interval": "day"}}]}',
    'https://bugzilla.mozilla.org/buglist.cgi?j_top=OR&keywords=regression%2C%20&keywords_type=anywords&f1=cf_blocking_b2g&columnlist=product%2Ccomponent%2Cassigned_to%2Cbug_status%2Cresolution%2Cshort_desc%2Cchangeddate%2Ckeywords%2Ccf_blocking_b2g&o1=anywordssubstr&resolution=FIXED&resolution=WONTFIX&query_format=advanced&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&bug_status=RESOLVED&bug_status=VERIFIED&bug_status=CLOSED&v1=1.4%2B&list_id=9731018' ),

('10','# Blocking Regressions ref. <version_title>',     '7', '#a6a6a6', '9,12',
    '',
    '' ),

('11','# Nominations for Blockers',                      '8', 'rgb(51, 51, 51)', '',
    '{"from": "public_bugs","select": {"name": "num","value": "bug_id","aggregate": "count"},"esfilter": {"and": [{"term": {"cf_blocking_b2g": "<version_tag:.>?"}}]},"edges": [{"range": {"min": "modified_ts","max": "expires_on"},"domain": {"type": "date","min": @birthday,"max": @timestamp,"interval": "day"}}]}',
    'https://bugzilla.mozilla.org/buglist.cgi?j_top=OR&f1=cf_blocking_b2g&o1=equals&query_format=advanced&bug_status=UNCONFIRMED&bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&bug_status=RESOLVED&bug_status=VERIFIED&bug_status=CLOSED&v1=<version_tag:.>%3F&list_id=9613973' ),

('12','# Nominations for Blockers ref. <version_title>', '8', '#a6a6a6', '11,12',
    '',
    '' );



