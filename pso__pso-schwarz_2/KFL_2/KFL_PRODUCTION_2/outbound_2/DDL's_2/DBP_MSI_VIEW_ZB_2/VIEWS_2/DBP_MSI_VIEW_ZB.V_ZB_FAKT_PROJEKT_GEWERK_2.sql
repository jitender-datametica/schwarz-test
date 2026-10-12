CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_zb_fakt_projekt_gewerk_2 (mandant_id
OPTIONS(description='MANDANT_2 IM DWH'), projekt_nr OPTIONS(description='EINDEUTIGE CODE DES PROJEKTES AUS EPPM. '),
gewerk_id OPTIONS(description='ID EINES GEWERKS , Z.BSP 3 = BAUKOSTEN'), wrg_typ_id
OPTIONS(description='ID DES WÄHRUNGSTYPS. GIBT AN OB ES SICH UM DIE KONZERNWÄHRUNG = 0 (EUR) ODER LANDESWÄHRUNG = 1 HANDELT'),
wrg_id OPTIONS(description='KURZBEZEICHNUNG DER WÄHRUNG, Z.B. CZK, EUR'), betrag_kostenprognose
OPTIONS(description='BETRAG DER DER AKTUELLEN KOSTENPROGNOSE AUF EBENE PROJEKT UND GEWERK.'), betrag_zek
OPTIONS(description='BETRAG DER NOCH ZU ERWARTENDEN KOSTEN DIE NICHT TEIL DER KOSTENPROGNOSE SIND (IN SAP MMK - MEHR- UND MINDERKOSTEN)'),
betrag_zek_manually
OPTIONS(description='BETRAG DER NOCH ZU ERWARTENDEN KOSTEN DIE NICHT TEIL DER KOSTENPROGNOSE SIND (WIRD MANUELL IM DASHBOARD EINGETRAGEN)'),
betrag_zea
OPTIONS(description='BETRAG DER ZU ERWARTENDEN AUFTRÄGE. WIR KALKULIERT ÜBER KOSTENPROGNOSE - (RECHNUNGSWERT + OBLIGO)  (IN SAP ZEA)'),
betrag_aktuelles_budget OPTIONS(description='BETRAG DES AKTUELLEN BUDGETS AUF EBENE PROJEKT UND GEWERK.'),
betrag_objektfreigabe_budget
OPTIONS(description='BETRAG DES BUDGETS ZUM ZEITPUNKT DER PROJEKTFREIGABE AUF EBENE PROJEKT UND GEWERK.'),
betrag_vertrag OPTIONS(description='BETRAG DER VERTRAGSWERTE AUF EBENE PROJEKT UND GEWERK'), betrag_bestellung_netto
OPTIONS(description='BETRAG NETTO DER BESTELLUNGEN AUF EBENE PROJEKT UND GEWERK'), betrag_bestellung_nachtrag_netto
OPTIONS(description='BETRAG NETTO DER NACHTRÄGE BEI  BESTELLUNGEN AUF EBENE PROJEKT UND GEWERK'), betrag_obligo
OPTIONS(description='BETRAG DES OBLIGOS AUF EBENE PROJEKT UND GEWERK.'), betrag_buchung
OPTIONS(description='BETRAG DER BUCHUNGEN DER RECHNUNGEN AUF EBENE PROJEKT UND GEWERK (KOSTEN TYP CD =\'K\' IN DBP_DATA.ZB_PROJEKT_IST_KOSTEN_2)'),
betrag_rueckstellung
OPTIONS(description='BETRAG DER RÜCKSTELLUNGEN AUF EBENE PROJEKT UND GEWERK (KOSTEN TYP CD =\'R\' IN DBP_DATA.ZB_PROJEKT_IST_KOSTEN_2)'),
anmerkung_txt OPTIONS(description='FREITEXT FÜR ANMERKUNGEN ZUM BERICHT AUF EBENE PROJEKT, GEWERK.'), td_update
OPTIONS(description='TECHNICAL FIELDS FOR SYNCHRONISATION FRAMEWORK. WILL BE DELTED AFTER LAST PRODUCT MIGRATION'),
td_insert
OPTIONS(description='TECHNICAL FIELDS FOR SYNCHRONISATION FRAMEWORK. WILL BE DELTED AFTER LAST PRODUCT MIGRATION'))
OPTIONS(DESCRIPTION = `FAKTENTABELLE AUF EBENE PROJEKT UND GEWERK FÜR PROJEKTDATEN AUS DEN ZENTRALBEREICHEN`) AS SELECT
 G.mandant_id,
 G.projekt_nr,
 G.gewerk_id,
 G.wrg_typ_id,
 G.wrg_id,
 G.betrag_kostenprognose,
 G.betrag_zek,
 TS1.betrag_zek AS betrag_zek_manually,
 G.betrag_zea,
 G.betrag_aktuelles_budget,
 G.betrag_objektfreigabe_budget,
 G.betrag_vertrag,
 G.betrag_bestellung_netto,
 G.betrag_bestellung_nachtrag_netto,
 G.betrag_obligo,
  CASE
  WHEN G.gewerk_id < 8
  THEN G.betrag_buchung
  WHEN G.gewerk_id = 8
  THEN G.betrag_baukostenzuschuss
  WHEN G.gewerk_id = 9
  THEN G.betrag_foerderung
  ELSE 0
  END AS betrag_buchung,
 G.betrag_rueckstellung,
 TS1.anmerkung_txt,
 G.td_insert AS td_update,
 G.td_update AS td_insert
FROM kfl_production_dbp_msi_data.zb_fakt_projekt_gewerk_2 AS G
 LEFT JOIN kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_2 AS TS1 ON G.mandant_id = TS1.mandant_id AND G.gewerk_id =
     TS1.gewerk_id AND G.projekt_nr = TS1.projekt_nr AND G.wrg_typ_id = TS1.wrg_typ_id
WHERE G.td_insert = (SELECT MAX(td_insert)
   FROM kfl_production_dbp_msi_data.zb_fakt_projekt_gewerk_2 AS T2);