CREATE TABLE IF NOT EXISTS ldl_data_etl.t712_bnl_config (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr BIGNUMERIC(38,0) NOT NULL,
c712_group_id INTEGER NOT NULL,
c712_group_name STRING(35) NOT NULL,
c712_position INTEGER NOT NULL,
c712_edit_flag INTEGER,
c712_groupname_nat STRING(35) NOT NULL,
c712_main_group INTEGER,
c712_date_from DATETIME NOT NULL,
c712_date_to DATETIME NOT NULL,
scn BIGNUMERIC(38,0) DEFAULT 0,
extraction_tmsp DATETIME,
PRIMARY KEY (c712_group_id, c712_group_name, c712_date_from, c712_date_to) NOT ENFORCED
);