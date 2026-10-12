CREATE TABLE DBP_DATA.OWG_PER (
	OWG_ID INTEGER NOT NULL COMMENT 'ID der Oberwarengruppe',
	ARTHIERTYP_ID INTEGER NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	DAT_VON DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
	DAT_BIS DATE COMMENT 'Datum im Format JJJJ-MM-TT',
	HWG_ID INTEGER COMMENT 'ID der Hauptwarengruppe',
	HR_OBJEKT_BEREICH_ID INTEGER COMMENT 'ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) INT Sicht',
	HR_OBJEKT_BEREICH_ID_DE INTEGER COMMENT 'ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) DE Sicht',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Oberwarengruppen -  Stufe in der Artikelhierarchie'
;