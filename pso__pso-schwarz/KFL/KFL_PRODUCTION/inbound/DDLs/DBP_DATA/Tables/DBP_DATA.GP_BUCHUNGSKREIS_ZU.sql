create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.GP_BUCHUNGSKREIS_ZU (
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
	GP_ID NUMBER(38,0) NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	EINKAUFSORGANISATION_ID NUMBER(38,0) NOT NULL COMMENT '1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
	BUCHUNGSKREIS_ID NUMBER(38,0) NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	ZAHLSPERRE_ID VARCHAR(1) COMMENT 'Eindeutiger Schluessel fuer eine Zahlsperre eines Lieferanten. Referenz zu der Tabelle l_zahlsperre;',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_GP_BUCHUNGSKREIS_ZU primary key (SYSTEM_ID, GP_ID, EINKAUFSORGANISATION_ID, BUCHUNGSKREIS_ID, MANDANT_ID)
)COMMENT='RPW - Buchungkreisabhängige Informationen zum Lieferanten aus der SAP Tabelle LFB1.'
;
