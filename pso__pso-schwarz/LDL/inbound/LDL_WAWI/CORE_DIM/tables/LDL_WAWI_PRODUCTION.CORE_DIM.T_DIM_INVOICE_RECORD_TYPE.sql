create or replace TABLE LDL_WAWI_PRODUCTION.CORE_DIM.T_DIM_INVOICE_RECORD_TYPE (
	RECORD_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Manuell befüllt',
	RECORD_TYPE_BEZ VARCHAR(100) COMMENT 'Manuell befüllt',
	constraint PK_T_DIM_INVOICE_RECORD_TYPE primary key (RECORD_TYPE_ID)
)COMMENT='Invoice Eintrag Typen.\n             0 = Rechnung\n             1 = Nachbelastung'
;