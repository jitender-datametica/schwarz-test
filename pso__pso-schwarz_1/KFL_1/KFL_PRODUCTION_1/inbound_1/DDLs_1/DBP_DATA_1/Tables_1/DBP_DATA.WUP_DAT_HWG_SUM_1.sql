create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.WUP_DAT_HWG_SUM_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'PK Mandant_1 im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'PK Warenumschlagsplatz',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT DATE NOT NULL COMMENT 'PK - Datum im Format JJJJ-MM_1-TT',
	HWG_ID NUMBER(38,0) NOT NULL COMMENT 'ID der Hauptwarengruppe',
	ARTHIERTYP_ID NUMBER(38,0) NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	BONANZAHL NUMBER(38,0) COMMENT 'Anzahl der Kassenbons',
	BONANZAHL_PRE_PACK NUMBER(38,0) COMMENT 'Anzahl der Kassenbons mit Pre-Pack Artikeln',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	BONANZAHL_SUG NUMBER(38,0) COMMENT 'Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.',
	constraint PK_WUP_DAT_HWG_SUM primary key (MANDANT_ID, WUP_ID, NB_ID, DAT, HWG_ID, ARTHIERTYP_ID)
)COMMENT='VIS - Tages-Aggregat pro Markt und Hauptwarengruppe'
;
