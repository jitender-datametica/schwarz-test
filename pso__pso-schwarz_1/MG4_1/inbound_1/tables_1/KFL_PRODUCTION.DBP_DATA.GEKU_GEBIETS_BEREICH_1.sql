create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_GEBIETS_BEREICH_1 (
	GEBIETS_BEREICH_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines Gebietsbereichs aus gbb_uid',
	VERTEILGEBIET_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID des Verteilgebiets',
	GEBIETS_BETREUER_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines Gebietsbetreuers',
	GEBIETS_BEREICH_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Bezeichnung der Gebietsbereiche aus code_name',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_GEBIETS_BEREICH primary key (GEBIETS_BEREICH_UID)
)COMMENT='GEKU - Lookup-Tabelle der Gebietsbereiche aus wmd_gbb_out'
;