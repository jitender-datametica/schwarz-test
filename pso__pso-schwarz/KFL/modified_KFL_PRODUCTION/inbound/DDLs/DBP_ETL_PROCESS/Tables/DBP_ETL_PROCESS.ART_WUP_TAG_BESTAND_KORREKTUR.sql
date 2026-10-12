CREATE OR REPLACE TABLE ART_WUP_TAG_BESTAND_KORREKTUR (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID INTEGER NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID INTEGER NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	ART_ID INTEGER NOT NULL,
	DAT_MHD DATE NOT NULL,
	PROZESS_KZ VARCHAR(10) NOT NULL,
	KL_ART_ID INTEGER NOT NULL COMMENT '7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer.',
	WG_ID INTEGER,
	WUG_ID INTEGER,
	MENGE_REST NUMBER(29,3),
	MENGE_WE_GES NUMBER(29,3),
	MENGE_EINH_ID VARCHAR(10),
	MHD_GRUPPE_ID INTEGER,
	ANZ_TAGE_SOLL_LIEFERZEIT INTEGER,
	ANZ_TAGE_SOLL_WE_BEARBEITUNG INTEGER,
	DATZEIT_ERSTELLUNG TIMESTAMP_LTZ(9),
	DATZEIT_AENDERUNG TIMESTAMP_LTZ(9),
	DATZEIT_EXTRAKT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_TAG_BESTAND_KORREKTUR primary key (MANDANT_ID, WUP_ID, NB_ID, DAT_MHD, PROZESS_KZ, ART_ID)
)COMMENT='SOURCE: SAP ZRS_STOCK_REDUCT'
;