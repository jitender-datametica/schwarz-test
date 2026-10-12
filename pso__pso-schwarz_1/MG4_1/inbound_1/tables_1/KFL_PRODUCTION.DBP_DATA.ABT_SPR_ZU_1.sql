create or replace TABLE KFL_PRODUCTION.DBP_DATA.ABT_SPR_ZU_1 (
	ABT_ID NUMBER(38,0) NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z. Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	SPR_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Sprache',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	ABT_BEZ VARCHAR(400) COLLATE 'en-ci' COMMENT 'Bezeichnung der Abteilung',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='VIS - Abteilung - Sprachen  - Zuordnung '
;