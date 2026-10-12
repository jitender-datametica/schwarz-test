CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_range_selection (
nfpo_range_sel_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_range_sel_nr STRING(100) NOT NULL,
nfpo_range_plan_nr STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_range_sel_sid) NOT ENFORCED
) OPTIONS(description='NFPO quarterly waves to define and order items             CBX: CNT_PROGRAM');