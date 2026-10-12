create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WUP_DAT_HWG_SUM(
	MANDANT_ID COMMENT 'PK Mandant im DWH',
	WUP_ID COMMENT 'PK Warenumschlagsplatz',
	NB_ID COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	DAT COMMENT 'PK - Datum im Format JJJJ-MM-TT',
	HWG_ID COMMENT 'ID der Hauptwarengruppe',
	ARTHIERTYP_ID COMMENT 'Artikel - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
	BONANZAHL COMMENT 'Anzahl der Kassenbons',
	BONANZAHL_PRE_PACK COMMENT 'Anzahl der Kassenbons mit Pre-Pack Artikeln',
	BONANZAHL_SUG COMMENT 'Anzahl der Kassenbons mit SUG/SDL-Logik. (SUG: Schwarz Unternehmensgruppe, SDL: Schwarz Dienstleistungen) Einheitliche Kunden-Definition der SUG/SDL: nur Bons mit mind. einer positiven Umsatzzeile, kein Imbiss und keine Alkohol- oder Inventurkassen.'
) as 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        dat,
        hwg_id,
        arthiertyp_id,
        bonanzahl,
        bonanzahl_pre_pack,
        bonanzahl_sug

FROM DBP_DATA.WUP_DAT_HWG_SUM ;
