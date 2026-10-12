/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_metric_client_item_day
   generated from Powerdesigner on Dienstag, 12. Dezember 2023 15:26:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_metric_client_item_day (
metric_type_id BIGNUMERIC(38,0) NOT NULL,
ldl_client_id BIGNUMERIC(38,0) NOT NULL,
ldl_item_sid BIGNUMERIC(38,0) NOT NULL,
cal_dt DATE NOT NULL,
metric_cnt BIGNUMERIC(38,0),
metric_qty BIGNUMERIC(38,5),
metric_val BIGNUMERIC(38,5),
metric_price BIGNUMERIC(38,5),
curr_cd STRING(3),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (metric_type_id, ldl_client_id, ldl_item_sid, cal_dt) NOT ENFORCED
) OPTIONS(description='Comment 2Do');