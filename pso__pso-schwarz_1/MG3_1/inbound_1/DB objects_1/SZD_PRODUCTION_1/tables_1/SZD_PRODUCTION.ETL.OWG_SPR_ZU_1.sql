create or replace TABLE SZD_PRODUCTION.ETL.OWG_SPR_ZU_1 (
	OWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Oberwarengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	OWG_BEZ VARCHAR(400) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Oberwarengruppe',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
);