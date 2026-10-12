create or replace TABLE KFL_PRODUCTION.DBP_DATA.WUG_SPR_ZU_1 (
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warengruppe',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	WUG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Warenuntergruppe',
	WUG_BEZ VARCHAR(160) COLLATE 'en-ci' COMMENT 'Warenuntergruppe - Bezeichnung',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='TP2_AIS - Sprachabhaengige Bezeichnungen der Warenuntergruppen'
;