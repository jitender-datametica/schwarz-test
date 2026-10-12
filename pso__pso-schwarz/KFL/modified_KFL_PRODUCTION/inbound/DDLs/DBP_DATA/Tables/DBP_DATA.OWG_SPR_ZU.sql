CREATE TABLE DBP_DATA.OWG_SPR_ZU (
	OWG_ID INTEGER NOT NULL COMMENT 'ID der Oberwarengruppe',
	ARTHIERTYP_ID INTEGER NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	SPR_ID INTEGER NOT NULL COMMENT 'ID der Sprache',
	OWG_BEZ VARCHAR(400) NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Oberwarengruppe',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Sprachabhängige Bezeichnung der Oberwarengruppen -  Stufe in der Artikelhierarchie'
;