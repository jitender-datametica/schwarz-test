create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_PRICE_LABEL_DAMAGE_REASON_2 (
	PRICE_LABEL_DAMAGE_REASON_ID NUMBER(38,0) NOT NULL COMMENT 'A unique code for the electronic price shield damage reason.',
	PRICE_LABEL_DAMAGE_REASON_DESCR VARCHAR(250) COMMENT 'A textual desciption for the electronic price shield damage reason.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The identifier of the last load run which inserted or updated this row.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was inserted.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the row was updated the last time.',
	constraint PK_T_REF_PRICE_LABEL_DAMAGE_REASON primary key (PRICE_LABEL_DAMAGE_REASON_ID)
)COMMENT='This reference table contains the list of possible defects (RMA - Return Material Authorization).\n             Currently coming from Solum and not available for Imagotag.\n             - Defektgrund schwache Batterie\n             - Defektgrund Display Defekt\n             - ESL Label außerhalb Empfangsreichweite\n             Source: Manually filled.'
;
