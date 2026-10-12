/* --------------------------------------------------------------------------------
   DDL for table: t_kfl_metric_gtp_item_advertise_day_1
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_kfl_metric_gtp_item_advertise_day_1 (
metric_type_id BIGNUMERIC(38,0) NOT NULL,
kfl_client_id BIGNUMERIC(38,0) NOT NULL,
kfl_gtp_nr BIGNUMERIC(38,0) NOT NULL,
kfl_gtp_subsidiary_type_id BIGNUMERIC(38,0) NOT NULL,
kfl_item_nr BIGNUMERIC(38,0) NOT NULL,
cal_week BIGNUMERIC(38,0) NOT NULL,
kfl_adv_period_type_id BIGNUMERIC(38,0) NOT NULL,
cal_dt DATE NOT NULL,
metric_cnt BIGNUMERIC(38,0),
metric_qty BIGNUMERIC(38,5),
metric_val BIGNUMERIC(38,5),
curr_cd STRING(3),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (metric_type_id, kfl_client_id, kfl_gtp_nr, kfl_gtp_subsidiary_type_id, kfl_item_nr, cal_week,
 kfl_adv_period_type_id) NOT ENFORCED
)
OPTIONS(description='Common table to store all extracted metrics from Kaufland DWH on the level goods transshipment point (Warenumschlagplatz), item_1 (Artikel_1) and advertising day. These metrics are used to calculate the percentage of sold items in a prromotion (Abverkaufsquote)');