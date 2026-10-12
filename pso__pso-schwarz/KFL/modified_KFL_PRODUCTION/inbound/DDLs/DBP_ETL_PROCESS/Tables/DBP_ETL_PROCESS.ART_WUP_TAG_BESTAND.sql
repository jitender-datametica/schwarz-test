CREATE OR REPLACE TABLE ART_WUP_TAG_BESTAND (
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID INTEGER NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID INTEGER NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	ART_ID INTEGER NOT NULL,
	KL_ART_ID INTEGER NOT NULL COMMENT '7-stellige Artikelnummer bestehend aus 2 Stellen: Warengruppe 4 Stellen: Artikelnummer 1 Stelle: Prüfziffer.',
	MENGE_LGBEST_ERP_FREI_BME NUMBER(29,3),
	MENGE_LGBEST_ERP_NACH_ABVERKAUF_BME NUMBER(29,3),
	MENGE_ABVERKAUF_BME NUMBER(29,3),
	DATZEIT_EXTRAKT TIMESTAMP_LTZ(9),
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_TAG_BESTAND primary key (MANDANT_ID, WUP_ID, NB_ID, ART_ID)
)COMMENT='SOURCE: SAP ZDMONLINESTOCKS4'
;