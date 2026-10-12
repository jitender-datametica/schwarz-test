create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_V_VIEW.V_ZB_FAKT_PROJEKT_GEWERK_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	PROJEKT_NR COMMENT 'Eindeutige Code des Projektes aus ePPM. ',
	GEWERK_ID COMMENT 'ID eines Gewerks , z.Bsp 3 = Baukosten',
	WRG_TYP_ID COMMENT 'ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	BETRAG_KOSTENPROGNOSE COMMENT 'Betrag der der aktuellen Kostenprognose auf Ebene Projekt und Gewerk.',
	BETRAG_ZEK COMMENT 'Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)',
	BETRAG_ZEA COMMENT 'Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)',
	BETRAG_AKTUELLES_BUDGET COMMENT 'Betrag des aktuellen Budgets auf Ebene Projekt und Gewerk.',
	BETRAG_OBJEKTFREIGABE_BUDGET COMMENT 'Betrag des Budgets zum Zeitpunkt der Projektfreigabe auf Ebene Projekt und Gewerk.',
	BETRAG_VERTRAG COMMENT 'Betrag der Vertragswerte auf Ebene Projekt und Gewerk',
	BETRAG_BESTELLUNG_NETTO COMMENT 'Betrag Netto der Bestellungen auf Ebene Projekt und Gewerk',
	BETRAG_BESTELLUNG_NACHTRAG_NETTO COMMENT 'Betrag Netto der Nachträge bei  Bestellungen auf Ebene Projekt und Gewerk',
	BETRAG_OBLIGO COMMENT 'Betrag des Obligos auf Ebene Projekt und Gewerk.',
	BETRAG_BUCHUNG COMMENT 'Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk (Kosten Typ CD = ''K'' in dbp_data.zb_projekt_ist_kosten_1)',
	BETRAG_BAUKOSTENZUSCHUSS COMMENT 'Betrag der Baukostenzuschuesse auf Ebene Projekt und Gewerk (Kosten Typ CD = ''B'' in dbp_data.zb_projekt_ist_kosten_1)',
	BETRAG_FOERDERUNG COMMENT 'Betrag der Foerderungen auf Ebene Projekt und Gewerk (Kosten Typ CD = ''F'' in dbp_data.zb_projekt_ist_kosten_1)',
	BETRAG_RUECKSTELLUNG COMMENT 'Betrag der Rückstellungen auf Ebene Projekt und Gewerk (Kosten Typ CD = ''R'' in dbp_data.zb_projekt_ist_kosten_1)'
) COMMENT='Faktentabelle auf Ebene Projekt und Gewerk für Projektdaten aus den Zentralbereichen'
 as 
    SELECT 
        mandant_id,
        projekt_nr,
        gewerk_id,
        wrg_typ_id,
        wrg_id,
        betrag_kostenprognose,
        betrag_zek,
        betrag_zea,
        betrag_aktuelles_budget,
        betrag_objektfreigabe_budget,
        betrag_vertrag,
        betrag_bestellung_netto,
        betrag_bestellung_nachtrag_netto,
        betrag_obligo,
        betrag_buchung,
        betrag_baukostenzuschuss,
        betrag_foerderung,
        betrag_rueckstellung

FROM DBP_MSI_DATA.ZB_FAKT_PROJEKT_GEWERK_1 ;
