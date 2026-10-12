/* --------------------------------------------------------------------------------
   DDL for table: t_metric_type_1
   generated from Powerdesigner on Donnerstag, 17. August 2023 15:33:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_metric_type_1 (
metric_type_id BIGNUMERIC(38,0) NOT NULL,
metric_type_name STRING(100),
metric_type_descr_de STRING(1000),
metric_type_descr_en STRING(1000),
lob_cd STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (metric_type_id) NOT ENFORCED
) OPTIONS(description='The metric type identifies metrics troughout all metric tables in the relational layer in NFPOW');