CREATE TABLE p_lew_core.t_store_group (
client_id INTEGER NOT NULL,
store_grp_sid INTEGER NOT NULL COMMENT 'Store Group Sid',
src_wh_nr VARCHAR(20) COLLATE 'en-ci' COMMENT 'Source Warehouse Number',
src_store_grp_id VARCHAR(20) COLLATE 'en-ci' COMMENT 'Source Store Group Id',
src_storgrp_id VARCHAR(30) COLLATE 'en-ci' COMMENT 'Source StorGrp Id',
store_grp_type_cd CHAR(5) COLLATE 'en-ci' NOT NULL COMMENT 'Store Group Type Code',
campaign_store_grp_type_cd CHAR(3) COLLATE 'en-ci' COMMENT 'Campaign Store Group Type Code',
store_grp_nr VARCHAR(20) COLLATE 'en-ci' COMMENT 'Store Group Number',
store_grp_name VARCHAR(100) COLLATE 'en-ci' COMMENT 'Store Group Name',
store_grp_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Store Group Description',
loc_sid_wh INTEGER,
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(6) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(6) NOT NULL,
CONSTRAINT t_store_group_pk PRIMARY KEY ( store_grp_sid ),
UNIQUE ( client_id ,store_grp_sid)
)
;

