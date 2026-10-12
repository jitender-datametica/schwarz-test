create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_HANDLING_UNIT_TYPE_2 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT',
	HANDLING_UNIT_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'HU / Pallet type code.',
	HANDLING_UNIT_TYPE_DESCR VARCHAR(250) COMMENT 'HU / Pallet type description.',
	PALLET_TYPE_CD VARCHAR(100) COMMENT 'Code for the pallet type, i.e. EP, DD, AE, etc. (for the HU it can be the first 2 characters of the HU type code, but not always).',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
	constraint PK_T_REF_HANDLING_UNIT_TYPE primary key (HANDLING_UNIT_TYPE_CD)
)COMMENT='Classification of handling units (HUs). It consists of the pallet type as well as load size and weight.\n             EWM source : /SCWM/THUTYP'
;
