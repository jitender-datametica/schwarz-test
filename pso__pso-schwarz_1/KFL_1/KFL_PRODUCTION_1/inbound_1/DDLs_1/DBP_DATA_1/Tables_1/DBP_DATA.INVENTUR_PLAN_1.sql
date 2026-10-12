create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.INVENTUR_PLAN_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	GJ NUMBER(38,0) NOT NULL COMMENT 'Geschäftsjahr, Format JJJJ',
	INVENTURART_ID NUMBER(38,0) NOT NULL COMMENT 'SRS: Inventurart (international nicht identisch)',
	OWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Oberwarengruppe',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_VK_NETTO NUMBER(38,4) COMMENT 'Geplanter Umsatz je OWG und Markt',
	BETRAG_VK_NETTO_INVENTUR_DIFF_PLAN NUMBER(38,4) COMMENT 'Geplante Inventurdifferenz je OWG, Inventurart und Markt',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_INVENTUR_PLAN primary key (MANDANT_ID, WUP_ID, NB_ID, GJ, INVENTURART_ID, OWG_ID)
)COMMENT='Planwerte für Umsatz und Inventurverluste je OWG und Inventurart pro Geschäftsjahr und Markt.'
;
