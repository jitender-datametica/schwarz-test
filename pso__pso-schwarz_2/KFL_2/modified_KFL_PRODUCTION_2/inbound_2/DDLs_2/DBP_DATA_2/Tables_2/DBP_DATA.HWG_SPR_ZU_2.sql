CREATE TABLE DBP_DATA.HWG_SPR_ZU_2 (
	HWG_ID INTEGER NOT NULL COMMENT 'ID der Hauptwarengruppe',
	ARTHIERTYP_ID INTEGER NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant_2 im DWH',
	SPR_ID INTEGER NOT NULL COMMENT 'ID der Sprache',
	HWG_BEZ VARCHAR(400) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Hauptwarengruppe',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Sprachabhängige Bezeichnung der Hauptwarengruppen -  Stufe in der Artikelhierarchie'
;