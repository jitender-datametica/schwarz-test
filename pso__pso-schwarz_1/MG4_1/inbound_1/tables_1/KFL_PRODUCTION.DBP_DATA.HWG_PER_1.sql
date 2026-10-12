create or replace TABLE KFL_PRODUCTION.DBP_DATA.HWG_PER_1 (
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	HWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Hauptwarengruppe',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT_VON DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT',
	DAT_BIS DATE COMMENT 'Datum im Format JJJJ-MM_1-TT',
	ABT_ID NUMBER(38,0) COMMENT 'Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen',
	HR_OBJEKT_BEREICH_ID NUMBER(38,0) COMMENT 'ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz)',
	HR_OBJEKT_BEREICH_ID_DE NUMBER(38,0) COMMENT 'ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) für DE',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Hauptwarengruppen -  Stufe in der Artikelhierarchie'
;