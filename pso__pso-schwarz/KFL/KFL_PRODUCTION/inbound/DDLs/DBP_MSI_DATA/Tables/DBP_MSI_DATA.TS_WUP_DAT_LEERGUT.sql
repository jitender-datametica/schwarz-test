create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_WUP_DAT_LEERGUT (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Nebenbetriebs ID, bei Märkten immer = 0',
	DAT DATE NOT NULL COMMENT 'Datum der Zählung des Leerguts.',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
	BETRAG_LEERGUT_ZAEHLUNG NUMBER(38,5) COMMENT 'Hausleiter zählt regelmäßig das Leergut und trägt dann den Wert in Landeswährung ein. Wird von Frontend (Transaction) per update/insert gepflegt.',
	BETRAG_LEERGUT_INVENTUR NUMBER(38,5) COMMENT 'Inventurwert von Leergut. Wird DWH intern aus Inventuren befüllt.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_WUP_DAT_LEERGUT primary key (MANDANT_ID, WUP_ID, NB_ID, DAT)
)COMMENT='Der Betrag des Leerguts in einer Filiale. Diese Information wird entweder durch eine jährliche Inventur oder eine monatliche Zählung,die vom Hausleiter durchgeführt wird,bekannt. Wird per Transaction und per AbInitio befüllt.'
;
