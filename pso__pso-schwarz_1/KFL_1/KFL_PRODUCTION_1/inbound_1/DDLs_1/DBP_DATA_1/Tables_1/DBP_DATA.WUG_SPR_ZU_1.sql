create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WUG_SPR_ZU_1 (
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	WUG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warenuntergruppe',
	WUG_BEZ VARCHAR(200) COLLATE 'en-ci' COMMENT 'Warenuntergruppe - Bezeichnung aus SAP Retail.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_WUG_SPR_ZU primary key (ARTHIERTYP_ID, MANDANT_ID, WG_ID, SPR_ID, WUG_ID)
)COMMENT='TP2_AIS - Sprachabhaengige Bezeichnungen der Warenuntergruppen\n             (ARTHIERTYP_ID nicht für PK benötigt)'
;
