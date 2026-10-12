create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.TRANSPORTATION_UNIT_KOSTEN (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum ( (hier: nur Speditionen))',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	TRANSPORTATION_UNIT_ID NUMBER(38,0) NOT NULL COMMENT 'Transporteinheit (intern)',
	KJ_TRANSPORTATION_UNIT NUMBER(38,0) NOT NULL COMMENT 'Anlagejahr der Transporteinheit',
	WRG_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_DIESEL NUMBER(11,3) COMMENT 'zusätzliche Kosten für Diesel',
	BETRAG_STROM NUMBER(11,3) COMMENT 'zusätzliche Kosten für Strom',
	BETRAG_GAS NUMBER(11,3) COMMENT 'zusätzliche Kosten für Gas',
	BETRAG_MAUT NUMBER(11,3) COMMENT 'zusätzliche Kosten für Maut',
	BETRAG_KUEHLUNG NUMBER(11,3) COMMENT 'zusätzliche Kosten für Kühlung',
	BETRAG_SONSTIGES NUMBER(11,3) COMMENT 'zusätzliche Kosten weitere',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TRANSPORTATION_UNIT_KOSTEN primary key (MANDANT_ID, WUP_ID, NB_ID, TRANSPORTATION_UNIT_ID, KJ_TRANSPORTATION_UNIT)
)COMMENT='Table for additional costs per transportation unit that are not included in WANKO billing data - main source is excel files, manually uploaded in Sharepoint'
;
