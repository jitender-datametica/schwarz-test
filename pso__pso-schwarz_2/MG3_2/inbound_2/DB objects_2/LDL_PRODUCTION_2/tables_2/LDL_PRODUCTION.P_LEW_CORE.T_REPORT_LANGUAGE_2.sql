create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_REPORT_LANGUAGE_2 (
	LANG_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key REPORT LANGUAGE',
	SRC_SPRAS VARCHAR(20) COMMENT 'Sprachenschluessel; SAP-Retail: t002.spras',
	LANG_NAME VARCHAR(100) COLLATE 'en-ci' COMMENT 'Bezeichnung der Sprache in Stiftungssprache; t002t.sptxt',
	ISO_CD VARCHAR(20) COMMENT 'Standard ISO Language Code (ISO639-1)',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_REPORT_LANGUAGE primary key (LANG_SID)
)COMMENT='$Revision: 0000 $. LANG; Sprachen;\n             SAP-Retail: T002;\n             SAP-BW: t_bw_z_ds_t002;\n             ELWIS: t_r_lang_map'
;