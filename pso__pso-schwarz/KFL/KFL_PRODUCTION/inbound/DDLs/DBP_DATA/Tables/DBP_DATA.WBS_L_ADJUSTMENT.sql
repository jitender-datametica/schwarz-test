create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WBS_L_ADJUSTMENT (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH.',
	ADJUSTMENT_ID NUMBER(38,0) NOT NULL COMMENT 'Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.',
	ADJUSTMENT_BEZ VARCHAR(200) NOT NULL COMMENT 'Beschreibung der adjustment_id, z. B. Standard adjustment',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_WBS_L_ADJUSTMENT primary key (MANDANT_ID, ADJUSTMENT_ID)
)COMMENT='Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.\n             0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R\n             1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.\n             2 = Platzhalter (Stand 28.03.2025)\n             3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine manuelle Bestellanlage durch das Land notwendig. '
;
