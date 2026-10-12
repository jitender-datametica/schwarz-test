create or replace TABLE KFL_PRODUCTION.DBP_DATA.GEKU_GEBIETSLEITER_1 (
	GEBIETSLEITER_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID des Gebietsleiters aus pc_nr',
	VERTRIEBSBUERO_UID NUMBER(18,0) NOT NULL COMMENT 'Eindeutige ID eines Vertriebsbüros aus rvl_nr',
	GEBIETSLEITER_BEZ VARCHAR(60) COLLATE 'en-ci' COMMENT 'Bezeichnung des Gebietsleiters',
	BERICHTS_EMPFAENGER_LDAP VARCHAR(10) COLLATE 'en-ci' COMMENT 'LDAP für den automatischen Versand von Berichten für den Gebietsleiter',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GEKU_GEBIETSLEITER primary key (GEBIETSLEITER_UID)
)COMMENT='GEKU - Lookup-Tabelle der Gebietsleiter aus wmd_pc_out'
;