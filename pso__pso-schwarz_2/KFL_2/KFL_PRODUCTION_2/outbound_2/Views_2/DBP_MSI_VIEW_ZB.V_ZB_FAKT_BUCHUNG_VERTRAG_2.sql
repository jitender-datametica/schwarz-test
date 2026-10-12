CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_zb_fakt_buchung_vertrag_2 (mandant_id
OPTIONS(description='MANDANT_2 IM DWH'), projekt_nr OPTIONS(description='EINDEUTIGE CODE DES PROJEKTES AUS EPPM. '),
gewerk_id OPTIONS(description='ID DES GEWERKES. ENTSPRICHT DER LETZTEN ZIFFER DES LANGEN PSP-ELEMENTS.'), vertrag_nr
OPTIONS(description='NUMMER DES VERTRAGES.'), gp_id OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
wrg_typ_id
OPTIONS(description='ID DES WÄHRUNGSTYPS. GIBT AN OB ES SICH UM DIE KONZERNWÄHRUNG = 0 (EUR) ODER LANDESWÄHRUNG = 1 HANDELT.'),
wrg_id OPTIONS(description='KURZBEZEICHNUNG DER WÄHRUNG, Z.B. CZK, EUR'), betrag_vertrag
OPTIONS(description='BETRAG DER VERTRAGSWERTE AUF EBENE PROJEKT UND GEWERK'), betrag_obligo
OPTIONS(description='BETRAG DES OBLIGOS AUF EBENE PROJEKT UND GEWERK.'), betrag_buchung
OPTIONS(description='BETRAG DER BUCHUNGEN DER RECHNUNGEN AUF EBENE PROJEKT UND GEWERK'), anmerkung_txt
OPTIONS(description='FREITEXT FÜR ANMERKUNGEN ZUM BERICHT AUF EBENE PROJEKT, GEWERK, WARENGRUPPE, KOSTENART_2'),
nicht_relevant_fg
OPTIONS(description='CODE, WELCHER ANGIBT, OB DIESER DATENSATZ FÜR DIE BERECHNUNG DER GESAMTSUMMEN IRRELEVANT IST (X) ODER NICHT (NULL)'))
AS SELECT G1.mandant_id,
 G1.projekt_nr,
 G1.gewerk_id,
 G1.vertrag_nr,
 G1.gp_id,
 G1.wrg_typ_id,
 G1.wrg_id,
 G1.betrag_vertrag,
 G1.betrag_obligo,
 G1.betrag_buchung,
 G2.anmerkung_txt,
 G2.nicht_relevant_fg
FROM kfl_production_dbp_msi_data.zb_fakt_buchung_vertrag_2 AS G1
 LEFT JOIN kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_vertrag_partner_2 AS G2 ON G1.mandant_id = G2.mandant_id AND
      G1.projekt_nr = G2.projekt_nr AND G1.gewerk_id = G2.gewerk_id AND G1.vertrag_nr = G2.vertrag_nr AND G1.gp_id = G2
   .gp_id;