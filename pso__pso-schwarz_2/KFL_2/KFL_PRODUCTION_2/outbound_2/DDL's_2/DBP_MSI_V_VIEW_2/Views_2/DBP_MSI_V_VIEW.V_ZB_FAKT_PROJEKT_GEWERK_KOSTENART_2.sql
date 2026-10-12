CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_zb_fakt_projekt_gewerk_kostenart_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), buchung_typ_cd
OPTIONS(description='Code gibt an ob es sich um eine_2 Buchung zu einer Bestellung (B), eine_2 Buchung zum Vertrag (V) oder um eine_2 Buchung ohne Bestellung und Vertrag (O) handelt.'),
krk_id OPTIONS(description='globale ID des Kostenrechnungskreises'), kostenart_id
OPTIONS(description='Eindeutiger Fachschluessel fuer die Kostenarten'), gp_id
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'), wrg_typ_id
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_buchung
OPTIONS(description='Betrag der Buchungen der Rechnungen auf Ebene Projekt,Gewerk und Kostenart_2'), betrag_rueckstellung
OPTIONS(description='Betrag der als Rückstellungen identifizierte Buchungen auf Ebene Projekt Gewerk und Kostenart_2'))
OPTIONS(DESCRIPTION = `Faktentabelle auf Ebene Projekt, Gewerk, Warengruppe und Kostenart_2  für Projektdaten aus den Zentralbereichen. Aktuell genutzt für Kennzahlen die sich nicht einer Bestellung oder einem Vertrag zuordnen lassen.`)
AS SELECT mandant_id,
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
FROM kfl_production_dbp_msi_data.zb_fakt_projekt_gewerk_kostenart_2;