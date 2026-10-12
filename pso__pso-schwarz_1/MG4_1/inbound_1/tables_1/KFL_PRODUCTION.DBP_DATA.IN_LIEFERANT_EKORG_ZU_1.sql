create or replace TABLE KFL_PRODUCTION.DBP_DATA.IN_LIEFERANT_EKORG_ZU_1 (
	IN_LIEF_ID NUMBER(38,0) NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
	EINKAUFSORGANISATION_ID NUMBER(38,0) NOT NULL COMMENT 'Einkaufsorganisation aus ekorg',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
	LOESCH_FG NUMBER(38,0) NOT NULL COMMENT 'Zentrale Löschvormerkung für Stammsatz aus loevm',
	EK_SPERR_FG NUMBER(38,0) NOT NULL COMMENT 'zentral vergebene Einkaufssperre aus sperm',
	EINKAEUFER_GRP_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'ID der Einkäufergruppe aus ekgr',
	ZAHLUNGSZIEL_ID VARCHAR(4) COLLATE 'en-ci' COMMENT 'ID der Zahlungsbedingung. Z.Bsp. 3030 = 30Tage, 3%',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IN_LIEFERANT_EKORG_ZU primary key (IN_LIEF_ID, EINKAUFSORGANISATION_ID, MANDANT_ID)
)COMMENT='BIS - Zuordnung Lieferant zu Einkaufsorganisation aus lfm1_1'
;