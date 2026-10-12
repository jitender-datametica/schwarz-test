CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_zb_fakt_buchung_bestellung_2 (mandant_id
OPTIONS(description='MANDANT_2 IM DWH'), projekt_nr OPTIONS(description='EINDEUTIGE CODE DES PROJEKTES AUS EPPM. '),
gewerk_id OPTIONS(description='ID DES GEWERKES. ENTSPRICHT DER LETZTEN ZIFFER DES LANGEN PSP-ELEMENTS.'), warengruppe_cd
OPTIONS(description='CODE DER WARENGRUPPE'), gp_id OPTIONS(description='GESCHÄFTSPARTNER - ID (LIEFERANTEN - ID)'),
wrg_typ_id
OPTIONS(description='ID DES WÄHRUNGSTYPS. GIBT AN OB ES SICH UM DIE KONZERNWÄHRUNG = 0 (EUR) ODER LANDESWÄHRUNG = 1 HANDELT.'),
wrg_id OPTIONS(description='KURZBEZEICHNUNG DER WÄHRUNG, Z.B. CZK, EUR'), betrag_bestellung_netto
OPTIONS(description='BETRAG NETTO DER BESTELLUNGEN AUF EBENE PROJEKT UND GEWERK'), betrag_bestellung_nachtrag_netto
OPTIONS(description='BETRAG NETTO DER NACHTRÄGE BEI  BESTELLUNGEN AUF EBENE PROJEKT UND GEWERK'), betrag_obligo
OPTIONS(description='BETRAG DES OBLIGOS AUF EBENE PROJEKT UND GEWERK.'), betrag_buchung
OPTIONS(description='BETRAG DER BUCHUNGEN DER RECHNUNGEN AUF EBENE PROJEKT UND GEWERK'), betrag_kostenprognose
OPTIONS(description='BETRAG DER KOSTENPROGNOSE IN LANDESWÄHRUNG'), betrag_zea
OPTIONS(description='BETRAG DER ZU ERWARTENDEN AUFTRÄGE. WIR KALKULIERT ÜBER KOSTENPROGNOSE - (RECHNUNGSWERT + OBLIGO) (IN SAP ZEA)'),
anmerkung_txt OPTIONS(description='FREITEXT FÜR ANMERKUNGEN ZUM BERICHT AUF EBENE PROJEKT, GEWERK, WARENGRUPPE, GP_2'),
nicht_relevant_fg
OPTIONS(description='CODE, WELCHER ANGIBT, OB DIESER DATENSATZ FÜR DIE BERECHNUNG DER GESAMTSUMMEN IRRELEVANT IST (X) ODER NICHT (NULL)'))
OPTIONS(DESCRIPTION = `FAKTENTABELLE FÜR BUCHUNGEN DIE EINER BESTELLUNG ZUGEORDNET WERDEN KÖNNEN AUF EBENE PROJEKT, GEWERK, WARENGRUPPE, LIEFERANT.`)
AS SELECT G.mandant_id,
 G.projekt_nr,
 G.gewerk_id,
 G.warengruppe_cd,
 G.gp_id,
 G.wrg_typ_id,
 G.wrg_id,
 G.betrag_bestellung_netto,
 G.betrag_bestellung_nachtrag_netto,
 G.betrag_obligo,
 G.betrag_buchung,
 G.betrag_kostenprognose,
 G.betrag_zea,
 TS1.anmerkung_txt,
 TS1.nicht_relevant_fg
FROM kfl_production_dbp_msi_data.zb_fakt_buchung_bestellung_2 AS G
 LEFT JOIN kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_wg_gp_2 AS TS1 ON G.mandant_id = TS1.mandant_id AND G.gewerk_id
       = TS1.gewerk_id AND G.projekt_nr = TS1.projekt_nr AND G.gp_id = TS1.gp_id AND G.warengruppe_cd = TS1.warengruppe_cd;