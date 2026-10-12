create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.TS_TP_OBJEKT_INFO (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	TP_OBJEKT_ID NUMBER(38,0) NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP',
	TP_OBJEKT_TYP VARCHAR(1) COMMENT 'Equipmenttyp',
	GEBAEUDE_BEZ VARCHAR(100) COMMENT 'Gebäude Bezeichnung',
	ANLAGE_BEZ VARCHAR(100) COMMENT 'Anlage Bezeichnung',
	ANLAGENGRUPPE_BEZ VARCHAR(100) COMMENT 'Anlagengruppe Bezeichnung',
	ANLAGENTEIL_BEZ VARCHAR(100) COMMENT 'Anlagenteil Bezeichnung',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_TP_OBJEKT_INFO primary key (MANDANT_ID, TP_OBJEKT_ID)
)COMMENT='Zusätzliche Informationen zum Equipment (SAP Industry). Grundgesamtheit ist der aktuell gültige Stand aus tp_objekt_per, die _bez-Felder werden durch ein TS Dokument versorgt.'
;
