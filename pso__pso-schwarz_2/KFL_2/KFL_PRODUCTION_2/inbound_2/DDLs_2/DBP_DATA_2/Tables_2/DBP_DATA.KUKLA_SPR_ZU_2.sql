create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.KUKLA_SPR_ZU_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	KUKLA_ID VARCHAR(2) NOT NULL COMMENT 'ID des Konkurrenten (z.B. 05 für Aldi Nord)',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'Sprach-ID der spr_zu-Tabellen',
	KUKLA_BEZ VARCHAR(200) NOT NULL COMMENT 'Bezeichnung des Konkurrenten',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_KUKLA_SPR_ZU primary key (MANDANT_ID, KUKLA_ID, SPR_ID)
)COMMENT='Sprachzuordnungstabelle der kukla_id, Wettbewerber ID (z.B. 05 für Aldi Nord) gem. ZEKEWK100'
;
