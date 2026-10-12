CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_unit_of_measurement_2 (
nfpo_uom_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_uom_nr STRING(100),
nfpo_uom_name STRING(100),
nfpo_uom_cd STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_uom_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. UOFM; Masseinheiten;              SAP-Retail-Tabelle: t006_2 & t006a;             SAP-BW: t_bw_z_ds_t006 & t_bw_z_ds_t006a;             ELWIS: t_s_uom;             WAWI: ');