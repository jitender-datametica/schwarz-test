CREATE TABLE p_lew_mart_cs.t_lago_item_descr_2
(
client_id NUMBER(38) NOT NULL,
item_id NUMBER(38) NOT NULL,
orig_item_nr NUMBER(38) NOT NULL,
item_descr VARCHAR(200) COLLATE 'en-ci',
language_id NUMBER(38) NOT NULL,
valid_from DATE NOT NULL,
valid_until DATE NOT NULL,
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL)
/**** WARNING: PERFORMANCE REVIEW - CLUSTER BY ****/
/*CLUSTER BY(RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 , NO RANGE))*/;