create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_AUSTR_GEBIET (
	WMD_AUSTRAEGER_GEBIET_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines Austrägergebiets',
	GEBIETS_BEREICH_UID NUMBER(18,0) COMMENT 'Eindeutige ID eines Gebietsbereichs aus gbb_uid',
	AUFLAGE NUMBER(38,0) COMMENT 'Auflage in Stück',
	SOLO_FG NUMBER(38,0) COMMENT 'Solo-Gebiet ja=1, nein=0',
	WMD_AUSTR_GEBIET_BEZ VARCHAR(250) COLLATE 'en-ci' COMMENT 'Bezeichnung des Austrägergebiets',
	AUSTR_GEBIET_LFD_NR NUMBER(38,0) COMMENT 'Mehrere Austrägergebiete können dieselbe Bezeichnung haben und unterscheiden sich durch eine laufende Nummer - vielleicht aber auch durch eine PLZ',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_AUSTR_GEBIET primary key (WMD_AUSTRAEGER_GEBIET_UID)
)COMMENT='GEKU - Lookup-Tabelle der Austrägergebiete aus wmd_at_out - MULTISET'
;