create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.OWG_PER_1 (
	OWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Oberwarengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	DAT_VON DATE NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT',
	DAT_BIS DATE COMMENT 'Datum im Format JJJJ-MM_1-TT',
	HWG_ID NUMBER(38,0) COMMENT 'ID der Hauptwarengruppe',
	HR_OBJEKT_BEREICH_ID NUMBER(38,0) COMMENT 'ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) INT Sicht',
	HR_OBJEKT_BEREICH_ID_DE NUMBER(38,0) COMMENT 'ID der Unterbereiche einer Filiale (letzte zwei Stellen des Quellfelds hr_objekt_bez_kurz) DE Sicht',
	TD_UPDATE TIMESTAMP_LTZ(9),
	TD_INSERT TIMESTAMP_LTZ(9)
)COMMENT='EK-INT - Oberwarengruppen -  Stufe in der Artikelhierarchie'
;
