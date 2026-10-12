CREATE TABLE p_lew_core.t_ref_plan_status_2
(
plan_status_cd CHAR(6) COLLATE 'en-ci' NOT NULL COMMENT 'Plan Status_2 Code',
plan_status_descr VARCHAR(100) COLLATE 'en-ci' COMMENT 'Plan Status_2 Description',
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT t_ref_plan_status_upi PRIMARY KEY ( plan_status_cd ))
;

