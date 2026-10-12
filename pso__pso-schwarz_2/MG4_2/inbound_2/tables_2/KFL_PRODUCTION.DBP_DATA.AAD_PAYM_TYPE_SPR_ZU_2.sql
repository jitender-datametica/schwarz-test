create or replace TABLE KFL_PRODUCTION.DBP_DATA.AAD_PAYM_TYPE_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH - ein Mandant_2 pro Land.',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	KPOS_ZAHLUNG_TYP_ID VARCHAR(4) NOT NULL COMMENT 'KPOS Zahlung Typ id',
	KPOS_ZAHLUNG_TYP_BEZ VARCHAR(50) COMMENT 'KPOS Zahlung typ Bezeichnung',
	PAYM_TYPE_NAME VARCHAR(100) COMMENT 'The payment type for the combination of mandant_id and kpos_zahlung_typ_id',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_AAD_PAYM_TYPE_SPR_ZU primary key (MANDANT_ID, SPR_ID, KPOS_ZAHLUNG_TYP_ID)
)COMMENT='Contains the translations of payment type (e.g. cash, ec) for each \"mandant_2\" and kpos_zahlung_typ_id'
;