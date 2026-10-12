/* --------------------------------------------------------------------------------
   DDL for table: t_report_language_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_report_language_2 (
lang_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key REPORT LANGUAGE'),
src_spras STRING(20) OPTIONS(description='Sprachenschluessel; SAP-Retail: t002.spras'),
lang_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Sprache in Stiftungssprache; t002t.sptxt'),
iso_cd STRING(20) OPTIONS(description='Standard ISO Language Code (ISO639-1)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (lang_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. LANG; Sprachen;             SAP-Retail: T002;             SAP-BW: t_bw_z_ds_t002;             ELWIS: t_r_lang_map');