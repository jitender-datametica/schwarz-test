create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_ZB_FAKT_BUCHUNG_BESTELLUNG_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.',
	WARENGRUPPE_CD COMMENT 'Code der Warengruppe',
	GP_ID COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
	WRG_TYP_ID COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_BESTELLUNG_NETTO COMMENT 'Betrag Netto der Bestellungen auf Ebene Projekt und Gewerk',
	BETRAG_BESTELLUNG_NACHTRAG_NETTO COMMENT 'Betrag Netto der Nachträge bei  Bestellungen auf Ebene Projekt und Gewerk',
	BETRAG_OBLIGO COMMENT 'Betrag des Obligos auf Ebene Projekt und Gewerk.',
	BETRAG_BUCHUNG COMMENT 'Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk',
	BETRAG_KOSTENPROGNOSE COMMENT 'Betrag der Kostenprognose in Landeswährung',
	BETRAG_ZEK COMMENT 'Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)',
	BETRAG_ZEA COMMENT 'Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)'
) COMMENT='Faktentabelle für Buchungen die einer Bestellung zugeordnet werden können auf Ebene Projekt, Gewerk, Warengruppe, Lieferant.'
 as 
    SELECT 
        mandant_id,
        projekt_nr,
        gewerk_id,
        warengruppe_cd,
        gp_id,
        wrg_typ_id,
        wrg_id,
        betrag_bestellung_netto,
        betrag_bestellung_nachtrag_netto,
        betrag_obligo,
        betrag_buchung,
        betrag_kostenprognose,
        betrag_zek,
        betrag_zea

FROM DBP_MSI_DATA.ZB_FAKT_BUCHUNG_BESTELLUNG_1 ;
