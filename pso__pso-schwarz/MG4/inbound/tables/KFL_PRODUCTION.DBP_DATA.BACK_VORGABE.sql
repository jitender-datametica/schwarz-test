create or replace TABLE KFL_PRODUCTION.DBP_DATA.BACK_VORGABE (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_CLUSTER_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID eines Wup Clusters. Wird im DWH erzeugt',
	WUG_CLUSTER_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige ID eines WGI-Cluster. Surrogate-Key, wird im DWH erstellt',
	BACK_DREHKLASSE_ID VARCHAR(2) NOT NULL COLLATE 'en-ci' COMMENT 'ID der für den Backshop definierten Drehklasse, z.Bsp. LD',
	AKTION_FG NUMBER(38,0) NOT NULL COMMENT 'Aktion-Flag. ! = Aktion, 0 = nicht in Aktion',
	KEY_BC_BEZ VARCHAR(100) NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'In der Quelle der sprechende Schlüssel der Tabelle aus dem Element key_bc. Wird compressed',
	AUFSCHLAG_ZEIT NUMBER(9,2) NOT NULL DEFAULT 0 COMMENT 'Aufschlag Uhrzeit aus auf_uz',
	ANT_MAG NUMBER(9,2) NOT NULL DEFAULT 0 COMMENT 'Anteil Minimum am Gesamt aus ant_mag',
	FAKTOR_IST NUMBER(9,2) NOT NULL DEFAULT 0 COMMENT 'Faktor auf Ist aus fak_ist',
	MIN_GESAMT_FS NUMBER(9,2) NOT NULL DEFAULT 0 COMMENT 'Minimum Gesamt Frühstart aus min_gf',
	ANT_MIN_FS NUMBER(9,2) NOT NULL DEFAULT 0 COMMENT 'Anteil Minimum Frühstart aus ant_mf',
	PROGNOSEART VARCHAR(10) NOT NULL COLLATE 'en-ci' DEFAULT '          ' COMMENT 'Prognoseart, z.Bsp. fc_max. Ist bisher im Modell nicht abgebildet, fc_max entspricht menge_prognose_max in der Tabelle fur_prognose aus prog_art',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_BACK_VORGABE primary key (MANDANT_ID, WUP_CLUSTER_ID, WUG_CLUSTER_ID, BACK_DREHKLASSE_ID, AKTION_FG)
)COMMENT='VIS Backshop - Parameter für den Backplan aus der Quelltabelle zek_bake_cntrl'
;