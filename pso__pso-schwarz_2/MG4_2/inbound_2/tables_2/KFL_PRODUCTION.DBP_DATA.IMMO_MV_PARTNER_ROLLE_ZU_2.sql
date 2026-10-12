create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_MV_PARTNER_ROLLE_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	MV_INTRENO VARCHAR(20) NOT NULL COMMENT 'Interner Schlüssel des Immobilienobjekts',
	ROLLE_KZ VARCHAR(7) NOT NULL COMMENT 'Geschäftspartner: Rolle',
	PARTNER_ID VARCHAR(10) NOT NULL COMMENT 'Geschäftspartnernummer',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_MV_PARTNER_ROLLE_ZU primary key (MANDANT_ID, MV_INTRENO, ROLLE_KZ, PARTNER_ID)
)COMMENT='IMMO - Zuordnung Partner (Zuständigkeit) zum Mietvertrag - SAP REFX - ZBI_RE_DATA_CN_IVS_PARTNER_VICNCN'
;