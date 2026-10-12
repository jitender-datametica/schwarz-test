create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_AUSTR_GEBIET_TAG (
	WMD_AUSTRAEGER_GEBIET_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines Austrägergebiets',
	DAT DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
	AUFLAGE NUMBER(38,0) NOT NULL COMMENT 'Auflage in Stück',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_AUSTR_GEBIET_TAG primary key (WMD_AUSTRAEGER_GEBIET_UID, DAT)
)COMMENT='GEKU - hier werden die Auflagen aus der Tabelle geku_austr_gebiet historisiert abgelegt'
;