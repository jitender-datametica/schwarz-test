create or replace TABLE KFL_PRODUCTION.DBP_DATA.IMMO_PLANUNG_MIETEINNAHMEN (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Planflache in Quadratmetern',
	WE_INTRENO VARCHAR(20) NOT NULL COLLATE 'en-ci',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Währungsid',
	PLANMIETE_PER_MONAT NUMBER(18,2) NOT NULL,
	PLANMIETE_PER_QM NUMBER(18,2) NOT NULL COMMENT 'Planmiete pro Quadratmeter',
	PLANFLAECHE NUMBER(18,4) NOT NULL COMMENT 'Planflaeche in Quadratmetern.',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IMMO_PLANUNG_MIETEINNAHMEN primary key (MANDANT_ID, WE_INTRENO)
)COMMENT='IMMO - Planung der Mieteinnahmen für das laufende Jahr. Werden jedes Jahr überschrieben.'
;