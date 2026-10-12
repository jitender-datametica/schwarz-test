/* --------------------------------------------------------------------------------
   DDL for table: t_report_language_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REPORT_LANGUAGE_1 (
   lang_sid                            NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key REPORT LANGUAGE',
   src_spras                           VARCHAR(20)      COMMENT 'Sprachenschluessel; SAP-Retail: t002.spras',
   lang_name                           VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Bezeichnung der Sprache in Stiftungssprache; t002t.sptxt',
   iso_cd                              VARCHAR(20)      COMMENT 'Standard ISO Language Code (ISO639-1)',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_REPORT_LANGUAGE PRIMARY KEY (lang_sid) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $. LANG; Sprachen;
             SAP-Retail: T002;
             SAP-BW: t_bw_z_ds_t002;
             ELWIS: t_r_lang_map';

