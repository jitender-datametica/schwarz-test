create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_ZB_FAKT_PROJEKT_GEWERK_KOSTENART(
	MANDANT_ID COMMENT 'Mandant im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	BUCHUNG_TYP_CD COMMENT 'Code gibt an ob es sich um eine Buchung zu einer Bestellung (B), eine Buchung zum Vertrag (V) oder um eine Buchung ohne Bestellung und Vertrag (O) handelt.',
	KRK_ID COMMENT 'globale ID des Kostenrechnungskreises',
	KOSTENART_ID COMMENT 'Eindeutiger Fachschluessel fuer die Kostenarten',
	GP_ID COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	WRG_TYP_ID COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_BUCHUNG COMMENT 'Betrag der Buchungen der Rechnungen auf Ebene Projekt,Gewerk und Kostenart',
	BETRAG_RUECKSTELLUNG COMMENT 'Betrag der als Rückstellungen identifizierte Buchungen auf Ebene Projekt Gewerk und Kostenart'
) COMMENT='Faktentabelle auf Ebene Projekt, Gewerk, Warengruppe und Kostenart  für Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich nicht einer Bestellung oder einem Vertrag zuordnen lassen.'
 as 
    SELECT 
        mandant_id,
        projekt_nr,
        gewerk_id,
        buchung_typ_cd,
        krk_id,
        kostenart_id,
        gp_id,
        wrg_typ_id,
        wrg_id,
        betrag_buchung,
        betrag_rueckstellung

FROM DBP_MSI_DATA.ZB_FAKT_PROJEKT_GEWERK_KOSTENART ;
