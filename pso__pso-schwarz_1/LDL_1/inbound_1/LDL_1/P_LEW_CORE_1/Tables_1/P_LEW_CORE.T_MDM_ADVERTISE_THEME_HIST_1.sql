create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'Technical column required by the used ETL framework\n            static 7 for all rows.',
	MDM_AD_THEME_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key NFPO ADVERTISING THEME.\n            CBX: CNT_PROJECT.REF_NO',
	CBX_PROJ_VERSION_NR NUMBER(38,0) NOT NULL COMMENT 'Technical version of the NFPO adv theme in the source system.\n            CBX: CNT_PROJECT.VERSION',
	CBX_PROJ_DOC_STATUS VARCHAR(100) COLLATE 'en-ci' COMMENT 'Technical status_1 of the NFPO adv theme in the source system (active, inactive, cancelled).\n            CBX: CNT_PROJECT.DOC_STATUS',
	CBX_PROJ_CHANGE_TMSP TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Change timestamp of the NFPO theme in the source system.\n            CBX: CNT_PROJECT.UPDATED_ON',
	MDM_RANGE_SEL_SID NUMBER(38,0) NOT NULL COMMENT 'Foreign Key NFPO RANGE SELECTION.\n            CBX: CNT_PROJECT.PROGRAM_REF',
	AD_THEME_APPROVAL_STATUS VARCHAR(100) COLLATE 'en-ci' COMMENT 'Adv theme approval status.\n            CBX: CNT_PROJECT.EDITING_STATUS',
	AD_THEME_WORKFLOW_STATUS VARCHAR(100) COLLATE 'en-ci' COMMENT 'NFPO adv theme workflow status.\n            CBX: CNT_PROJECT.STATUS_1 (New --> New; customStatus01 --> Selection)',
	AD_THEME_SELL_FROM_DAY NUMBER(38,0) COMMENT 'Day of the advertising week on which sales_1 start. Usually there are 2 days in an advertising week where actions start, for example Monday and Thursday. This number indicates whether the first or the second is used for the theme.\n            CBX: CTM_PROJECT.CUST_CODELIST3',
	AD_THEME_SELL_FROM_DT DATE COMMENT 'Date on which sales_1 start, generally in the advertising week of this theme.\n            CBX: CTM_PROJECT.CUST_DATE1',
	DELETED_FG NUMBER(38,0) NOT NULL COMMENT 'If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
	DWH_VALID_FROM DATE NOT NULL COMMENT 'Beginning of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).',
	DWH_VALID_TO DATE NOT NULL COMMENT 'End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	AD_THEME_RESP_BUYER_SID NUMBER(38,0) COMMENT 'Responsible person for the advertising theme.\n            CBX: CNT_PROJECT.THEME_OWNER',
	MDM_PREV_AD_THEME_SID NUMBER(38,0) COMMENT 'Foreign Key NFPO ADVERTISING THEME for the advertising theme which is referenced as preceeding advertise theme that covered the same or a similar topic and same or similar items.\n            CBX: CTM_PROJECT.CUST_TEXT2',
	constraint PK_T_MDM_ADVERTISE_THEME_HIST primary key (MDM_AD_THEME_SID, DWH_VALID_FROM)
)COMMENT='Historized attributes of NFPO advertising themes.\n             CBX: CNT_PROJECT, CTM_PROJECT'
;
