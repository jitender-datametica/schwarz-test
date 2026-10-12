CREATE TABLE p_lew_mart_cs.t_lago_item
(
client_id NUMBER(38) NOT NULL,
country_iso_cd VARCHAR(20) COLLATE 'en-ci' NOT NULL,
item_id NUMBER(38) NOT NULL,
orig_item_nr DECIMAL(18,0) NOT NULL,
orig_item_nr_int DECIMAL(9,0),
case_size_lago NUMBER(38),
valid_from DATE ,
valid_until DATE ,
brand_name VARCHAR(100) COLLATE 'en-ci',
item_actiongroup_id NUMBER(38),
item_sub_actiongroup_id NUMBER(38),
is_plu_item SMALLINT,
plu_nr NUMBER(38),
buying_list_type_id NUMBER(38),
unitsize VARCHAR(100) COLLATE 'en-ci',
buying_employee_skey NUMBER(38),
buying_employee_name VARCHAR(100) COLLATE 'en-ci',
subitemgroup_id NUMBER(38),
int_subitemgroup_id NUMBER(38),
itemstatus_cd NUMBER(38),
packagetype_desc VARCHAR(100) COLLATE 'en-ci',
item_familygroup_id NUMBER(38),
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL)
/**** WARNING: PERFORMANCE REVIEW - CLUSTER BY ****/
/*CLUSTER BY(RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 , NO RANGE))*/;
