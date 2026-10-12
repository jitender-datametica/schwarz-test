CREATE TABLE DBP_DATA.HWG_PER (
	ARTHIERTYP_ID INTEGER NOT NULL COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	HWG_ID INTEGER NOT NULL COMMENT 'ID der Hauptwarengruppe',
	MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
	DAT_VON DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
	DAT_BIS DATE COMMENT 'Datum im Format JJJJ-MM-TT',
	ABT_ID INTEGER COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
	HR_OBJEKT_BEREICH_ID INTEGER COMMENT 'ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz)',
	HR_OBJEKT_BEREICH_ID_DE INTEGER COMMENT 'ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) für DE',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Hauptwarengruppen -  Stufe in der Artikelhierarchie'
;