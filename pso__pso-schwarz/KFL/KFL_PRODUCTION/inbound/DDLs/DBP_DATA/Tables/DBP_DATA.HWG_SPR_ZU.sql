create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.HWG_SPR_ZU (
	HWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Hauptwarengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	HWG_BEZ VARCHAR(400) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Hauptwarengruppe',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Sprachabhängige Bezeichnung der Hauptwarengruppen -  Stufe in der Artikelhierarchie'
;
