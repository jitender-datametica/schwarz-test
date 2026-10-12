create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_MIETVERTRAG_WE_ZU_PER_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	MV_INTRENO VARCHAR(20) NOT NULL COMMENT 'Interner Schlüssel des Immobilienobjekts',
	WE_INTRENO VARCHAR(20) NOT NULL COMMENT 'Interner Schlüssel der Wirtschaftseinheit',
	DAT_VON DATE NOT NULL COMMENT 'Datum: Beziehung gültig ab',
	DAT_BIS DATE NOT NULL COMMENT 'Datum: Beziehung gültig bis',
	ZUORDNUNG_INFO_KZ VARCHAR(1) NOT NULL COMMENT 'Intreno der Wirtschaftseinheit',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_MIETVERTRAG_WE_ZU_PER primary key (MANDANT_ID, MV_INTRENO, WE_INTRENO, DAT_VON)
)COMMENT='IMMO - Zuordnung Mietvertrag zu Wirtschaftseinheit - SAP REFX - ZBI_RE_DATA_CN_OBJECT_REL_VICNCN'
;