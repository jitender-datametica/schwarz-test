create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WUP_PLAN_KJMO_OWG (
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	KJMO NUMBER(38,0) NOT NULL COMMENT 'Monat eines Kalenderjahres, Format JJJJMM',
	HWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Hauptwarengruppe',
	WRG_ID VARCHAR(3) COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	UMSATZ_NETTO_PLAN NUMBER(18,2) COMMENT 'geplanter Nettoumsatz / Umsatzplanwert',
	ABSCHRIFTEN_NETTO_OPERATIV_PLAN NUMBER(18,2) COMMENT 'Abschriftenplanwert für operative Abschriften. Total- + Preisabschriften',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	BETRAG_VK_NETTO_INVENTUR_DIFF_PLAN NUMBER(38,4) COMMENT 'Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur-Zeitraum',
	constraint PK_WUP_PLAN_KJMO_OWG primary key (WUP_ID, NB_ID, MANDANT_ID, KJMO, HWG_ID)
)COMMENT='VIS - Planwerte pro Markt / Mandant / Monat / Haupwarengruppe (hwg)'
;
