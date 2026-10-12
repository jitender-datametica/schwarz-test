CREATE OR REPLACE TABLE ldl_production_p_lew_core.t_report_language_1 (
lang_sid INTEGER NOT NULL OPTIONS(description='Surrogate Key REPORT LANGUAGE'),
src_spras STRING(20) OPTIONS(description='Sprachenschluessel; SAP-Retail: t002.spras'),
lang_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Sprache in Stiftungssprache; t002t.sptxt'),
iso_cd STRING(20) OPTIONS(description='Standard ISO Language Code (ISO639-1)'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (lang_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. LANG; Sprachen;\n             SAP-Retail: T002;\n             SAP-BW: t_bw_z_ds_t002;\n             ELWIS: t_r_lang_map');