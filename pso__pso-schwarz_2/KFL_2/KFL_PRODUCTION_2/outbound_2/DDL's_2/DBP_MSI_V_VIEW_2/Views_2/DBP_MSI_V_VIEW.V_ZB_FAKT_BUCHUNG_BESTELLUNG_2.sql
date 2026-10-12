CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_zb_fakt_buchung_bestellung_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), projekt_nr OPTIONS(description='Eindeutige Code des Projektes aus ePPM. '),
gewerk_id OPTIONS(description='ID des Gewerkes. Entspricht der letzten Ziffer des langen PSP-Elements.'), warengruppe_cd
OPTIONS(description='Code der Warengruppe'), gp_id OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
wrg_typ_id
OPTIONS(description='ID des Währungstyps. Gibt an ob es sich um die Konzernwährung = 0 (EUR) oder Landeswährung = 1 handelt.'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.B. CZK, EUR'), betrag_bestellung_netto
OPTIONS(description='Betrag Netto der Bestellungen auf Ebene Projekt und Gewerk'), betrag_bestellung_nachtrag_netto
OPTIONS(description='Betrag Netto der Nachträge bei  Bestellungen auf Ebene Projekt und Gewerk'), betrag_obligo
OPTIONS(description='Betrag des Obligos auf Ebene Projekt und Gewerk.'), betrag_buchung
OPTIONS(description='Betrag der Buchungen der Rechnungen auf Ebene Projekt und Gewerk'), betrag_kostenprognose
OPTIONS(description='Betrag der Kostenprognose in Landeswährung'), betrag_zek
OPTIONS(description='Betrag der noch zu erwartenden Kosten die nicht Teil der Kostenprognose sind (in SAP MMK - Mehr- und Minderkosten)'),
betrag_zea
OPTIONS(description='Betrag der zu erwartenden Aufträge. Wir kalkuliert über Kostenprognose - (Rechnungswert + Obligo)  (in SAP ZEA)'))
OPTIONS(DESCRIPTION = `Faktentabelle für Buchungen die einer Bestellung zugeordnet werden können auf Ebene Projekt, Gewerk, Warengruppe, Lieferant.`)
AS SELECT mandant_id,
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
FROM kfl_production_dbp_msi_data.zb_fakt_buchung_bestellung_2;