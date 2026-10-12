CREATE TABLE p_lew_mart_cs.t_lago_itemfamily
(
client_id NUMBER(38) NOT NULL,
country_iso_cd VARCHAR(20) COLLATE 'en-ci' NOT NULL,
dat_rec_start DATE  NOT NULL,
dat_rec_end DATE  NOT NULL,
item_familygroup_id NUMBER(38) NOT NULL,
itemfamily_cd NUMBER(38),
desc_short VARCHAR(300) COLLATE 'en-ci',
desc_long VARCHAR(300) COLLATE 'en-ci' NOT NULL,
language_id NUMBER(38) NOT NULL,
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL)
/**** WARNING: PERFORMANCE REVIEW - CLUSTER BY ****/
/*CLUSTER BY(RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 , NO RANGE))*/;
