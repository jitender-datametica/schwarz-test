create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_WARENBEWERTUNG_ABSCHLUSS_BELADUNG (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	DAT_AENDERUNG DATE NOT NULL COMMENT 'Das Datum, an dem die Änderungen vorgenommen wurden.',
	JOB_START_FG NUMBER(38,0) DEFAULT 0 COMMENT 'Flag ob Beladungsjob rueckwirkend für die dat_aenderung gestartet werden sollte. 0 - Job soll nicht gestartet werden , 1 - Job soll gestartet werden.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_WARENBEWERTUNG_ABSCHLUSS_BELADUNG primary key (MANDANT_ID, DAT_AENDERUNG)
)COMMENT='Die Tabelle dient als Steuerung für die rückwirkende Beladung der Tabelle dbp_data.warenbewertung_abschluss.FB trägt für welches Datum und Land, Änderungen vorgekommen sind, ein und diese sollten in der Tabelle nachbeladen werden (es dreht nicht um die \""normale\"" Beladung ).'
;
