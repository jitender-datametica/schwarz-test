create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_DATA.TS_BESTWERTFORTSCHREIBUNG (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Nebenbetrieb z.Bsp.: 0 = Markt',
	DAT DATE NOT NULL COMMENT 'Tag für den die manuellen Eingaben getätigt werden',
	OWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Oberwarengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Hierarchietyp Seit 2010 immer 2',
	UMSATZ_PLAN_BRUTTO_OWG NUMBER(18,4) COMMENT 'Planwert Umsatz HL brutto - Pflege über Frontend',
	WARENEINGANG_BRUTTO_OWG NUMBER(18,4) COMMENT 'Wareneingang brutto - IST - Pflege über Frontend',
	SCHLUSSBESTAND_VORMONAT_BRUTTO_OWG NUMBER(18,4) COMMENT 'Voraussichtlicher Schlussbestand Brutto Vormonat - IST - Pflege über Frontend',
	DATZEIT_PFLEGE TIMESTAMP_LTZ(9) NOT NULL COMMENT 'datzeit_pflege zur Kontrolle bei druecken Button speichern',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Landeswährung - Pflege über Frontend, abhängig vom Mandant',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TS_BESTWERTFORTSCHREIBUNG primary key (MANDANT_ID, WUP_ID, NB_ID, DAT, OWG_ID, ARTHIERTYP_ID, WRG_ID)
)COMMENT='VIS - Transaction Frontend - Pflegetabelle für VIS Bericht Bestellfortschreibung.'
;
