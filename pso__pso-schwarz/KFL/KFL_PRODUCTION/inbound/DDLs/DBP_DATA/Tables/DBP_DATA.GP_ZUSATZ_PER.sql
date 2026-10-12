create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.GP_ZUSATZ_PER (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	EINKAUFSORGANISATION_ID NUMBER(38,0) NOT NULL COMMENT '1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
	DAT_VON DATE NOT NULL COMMENT 'Gueltigkeitbeginn des Datensatzes;',
	DAT_BIS DATE COMMENT 'Gueltigkeitsende des Datensatzes.',
	ENTGELT_MIND_KZ VARCHAR(1) COMMENT 'Kennzeichen Entgeltminderungsvereinbarung (1 entspricht Entgeltminderung vereinbart).',
	RET_SPERRPROFIL_ID VARCHAR(3) COMMENT 'Modus fuer Retourenabrechnung (z. B. GS fuer Gutschriftsabwicklung);',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GP_ZUSATZ_PER primary key (MANDANT_ID, GP_ID, EINKAUFSORGANISATION_ID, DAT_VON)
)COMMENT='RPW - Zeitabhängige Informationen zu den Retouren eines Lieferanten aus den SAP Tabellen ZRP_RT_CONTR sowie ZRP_FEE_REDUCT.'
;
