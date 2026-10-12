CREATE TABLE p_lew_mart_cs.t_lago_supplier_1
(
client_id NUMBER(38) NOT NULL,
country_iso_cd VARCHAR(20) COLLATE 'en-ci' NOT NULL,
orig_supplier_nr NUMBER(38) NOT NULL,
supplier_id NUMBER(38) NOT NULL,
cs_updated TIMESTAMP_NTZ(9) NOT NULL,
cs_created TIMESTAMP_NTZ(9) NOT NULL,
cs_load_id NUMBER(38) NOT NULL)
;
