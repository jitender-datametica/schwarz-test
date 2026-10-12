create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_GES_VERTRIEBSLTG (
	COUNTRY_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID des Landes aus country_nr',
	LAND_ISO VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'ISO - Kürzel des Landes (z.Bsp. DE)',
	LAND_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Bezeichnung des Landes',
	VERTEILTAG_ID NUMBER(38,0) COMMENT 'Entspricht der wtag_id des Datenmodells. Von 1 bis 7, wobei Montag = 1',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_GES_VERTRIEBSLTG primary key (COUNTRY_UID)
)COMMENT='GEKU - Lookup Tabelle der Gesamtvertriebsleitung'
;