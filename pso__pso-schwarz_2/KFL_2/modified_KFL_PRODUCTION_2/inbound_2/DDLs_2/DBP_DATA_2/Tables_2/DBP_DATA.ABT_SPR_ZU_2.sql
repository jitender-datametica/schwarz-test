CREATE TABLE DBP_DATA.ABT_SPR_ZU_2 (
	ABT_ID INTEGER NOT NULL COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
	ARTHIERTYP_ID INTEGER NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z. Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	SPR_ID INTEGER NOT NULL COMMENT 'ID der Sprache',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	ABT_BEZ VARCHAR(400) COLLATE 'en-ci' COMMENT 'Bezeichnung der Abteilung',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='VIS - Abteilung - Sprachen  - Zuordnung '
;