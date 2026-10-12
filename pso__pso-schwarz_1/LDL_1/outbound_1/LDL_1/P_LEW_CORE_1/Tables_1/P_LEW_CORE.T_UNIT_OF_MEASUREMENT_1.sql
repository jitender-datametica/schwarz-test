/* --------------------------------------------------------------------------------
   DDL for table: t_unit_of_measurement_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_unit_of_measurement_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
uom_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key UNIT_1 OF MEASUREMENT'),
src_msehi STRING(20) OPTIONS(description='Masseinheit; SAP-Retail: t006.msehi; SAP-BW: t_bw_z_ds_t006.msehi'),
uom_sid_family BIGNUMERIC(38,0)
OPTIONS(description='Masseinheitenfamilie; FK auf UNIT_1 OF MEASUREMENT; SAP-Retail: t006.famunit; SAP-BW: t_bw_z_ds_t006.famunit'),
uom_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Masseinheiten-Beschreibung in Stiftungssprache; SAP-Retail: t006a.msehl; SAP-BW: t_bw_z_ds_t006a.msehl'),
uom_iso_cd STRING(20)
OPTIONS(description='Iso-Code Masseinheit; SAP-Retail: t006.isocode; SAP-BW: t_bw_z_ds_t006.isocode'),
uom_cd_family STRING(20)
OPTIONS(description='Masseinheitenfamilie; SAP-Retail: t006.famunit; SAP-BW: t_bw_z_ds_t006.famunit'),
numerator_conv_si BIGNUMERIC(38,0)
OPTIONS(description='Zaehler zur Umrechnung in SI-Einheit; SAP-Retail: t006.zaehl; SAP-BW: t_bw_z_ds_t006 zaehl'),
denominator_conv_si BIGNUMERIC(38,0)
OPTIONS(description='Nenner zur Umrechnung in SI-Einheit; SAP-Retail: t006.nennr; SAP-BW: t_bw_z_ds_t006.nennr'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (uom_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. UOFM; Masseinheiten;              SAP-Retail-Tabelle: t006_1 & t006a;             SAP-BW: t_bw_z_ds_t006 & t_bw_z_ds_t006a;             ELWIS: t_s_uom;             WAWI: ');