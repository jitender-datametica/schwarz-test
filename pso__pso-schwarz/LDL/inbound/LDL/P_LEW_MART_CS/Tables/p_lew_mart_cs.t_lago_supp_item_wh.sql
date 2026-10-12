CREATE TABLE p_lew_mart_cs.t_lago_supp_item_wh
(
client_id NUMBER(38) NOT NULL,
country_iso_cd VARCHAR(20) COLLATE 'en-ci' NOT NULL,
wh_id NUMBER(38) NOT NULL,
supplier_id NUMBER(38) NOT NULL,
item_id NUMBER(38) NOT NULL,
valid_from DATE,
valid_until DATE,
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL)
/**** WARNING: PERFORMANCE REVIEW - CLUSTER BY ****/
/*CLUSTER BY(RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 , NO RANGE))*/;
