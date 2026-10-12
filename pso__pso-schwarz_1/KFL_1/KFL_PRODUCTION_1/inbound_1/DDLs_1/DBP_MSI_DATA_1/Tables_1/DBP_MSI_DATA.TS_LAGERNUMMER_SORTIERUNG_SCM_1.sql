create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_LAGERNUMMER_SORTIERUNG_SCM_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 in DWH.',
	LAGERNUMMER_ID VARCHAR(4) NOT NULL COMMENT 'Lagernummer / Lagerkomplex.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stellen der Marktnummer, die Nebenbetriebskennziffer.',
	LAGERSORTIMENT_ID VARCHAR(1) NOT NULL COMMENT 'Lagersortiment ID.',
	ARTIKELSORTIMENT_ID VARCHAR(1) NOT NULL COMMENT 'Artikelsortiment ID.',
	LAGERNUMMER_SORTIERUNG_SCM_ID VARCHAR(10) NOT NULL COMMENT 'Lagernummersortierung SCM.',
	LAGERNUMMER_SORTIERUNG_SCM_BEZ VARCHAR(255) COMMENT 'Lagernummersortierung SCM (Bezeichnung).',
	DAT_PFLEGE_LAYOUT DATE COMMENT 'Datum, seit dem das Layout eines Verteilzentrums in SAP gepflegt wird. Das Layout wird benötigt um Entfernungen und darauf basierende Kennzahlen auszurechnen. Das Datum wird benötigt um zu verhindern, dass Kennzahlen zu einem Zeitraum gezogen werden, für den es noch kein fertiges / freigegebenes Layout gab.',
	DAT_TMS_WANKO DATE COMMENT 'Golive Datum des WANKO TMS.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_LAGERNUMMER_SORTIERUNG_SCM primary key (MANDANT_ID, LAGERNUMMER_ID, WUP_ID, NB_ID, LAGERSORTIMENT_ID, ARTIKELSORTIMENT_ID, LAGERNUMMER_SORTIERUNG_SCM_ID)
)COMMENT='LIS - Lagernummer Sortierung SCM.'
;
