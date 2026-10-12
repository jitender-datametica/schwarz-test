CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_zb.v_zb_fakt_projekt_gewerk_kostenart_2 (mandant_id
OPTIONS(description='MANDANT_2 IM DWH'), projekt_nr OPTIONS(description='EINDEUTIGE CODE DES PROJEKTES AUS EPPM. '),
gewerk_id OPTIONS(description='ID DES GEWERKES. ENTSPRICHT DER LETZTEN ZIFFER DES LANGEN PSP-ELEMENTS.'), buchung_typ_cd
OPTIONS(description='CODE GIBT AN OB ES SICH UM EINE_2 BUCHUNG ZU EINER BESTELLUNG (B), EINE_2 BUCHUNG ZUM VERTRAG (V) ODER UM EINE_2 BUCHUNG OHNE BESTELLUNG UND VERTRAG (O) HANDELT.'),
krk_id OPTIONS(description='GLOBALE ID DES KOSTENRECHNUNGSKREISES'), kostenart_id
OPTIONS(description='EINDEUTIGER FACHSCHLUESSEL FUER DIE KOSTENARTEN'), wrg_typ_id
OPTIONS(description='ID DES WÄHRUNGSTYPS. GIBT AN OB ES SICH UM DIE KONZERNWÄHRUNG = 0 (EUR) ODER LANDESWÄHRUNG = 1 HANDELT.'),
wrg_id OPTIONS(description='KURZBEZEICHNUNG DER WÄHRUNG, Z.B. CZK, EUR'), betrag_buchung
OPTIONS(description='BETRAG DER BUCHUNGEN DER RECHNUNGEN AUF EBENE PROJEKT UND GEWERK'), betrag_rueckstellung
OPTIONS(description='BETRAG DER ALS RÜCKSTELLUNGEN IDENTIFIZIERTE BUCHUNGEN AUF EBENE PROJEKT GEWERK UND KOSTENART_2'),
anmerkung_txt OPTIONS(description='FREITEXT FÜR ANMERKUNGEN ZUM BERICHT AUF EBENE PROJEKT, GEWERK,, KOSTENART_2'),
nicht_relevant_fg
OPTIONS(description='CODE, WELCHER ANGIBT, OB DIESER DATENSATZ FÜR DIE BERECHNUNG DER GESAMTSUMMEN IRRELEVANT IST (X) ODER NICHT (NULL)'))
OPTIONS(DESCRIPTION = `FAKTENTABELLE AUF EBENE PROJEKT, GEWERK, WARENGRUPPE UND KOSTENART_2  FÜR PROJEKTDATEN AUS DEN ZENTRALBEREICHEN. AKTUELL GENUTZT FÜR KENNZAHLEN DIE SICH NICHT EINER BESTELLUNG ODER EINEM VERTRAG ZUORDNEN LASSEN.`)
AS SELECT G1.mandant_id,
 G1.projekt_nr,
 G1.gewerk_id,
 G1.buchung_typ_cd,
 G1.krk_id,
 SUBSTR(G1.kostenart_id, 5, 7) AS kostenart_id,
 G1.wrg_typ_id,
 G1.wrg_id,
 G1.betrag_buchung,
 G1.betrag_rueckstellung,
 G2.anmerkung_txt,
 G2.nicht_relevant_fg
FROM kfl_production_dbp_msi_data.zb_fakt_projekt_gewerk_kostenart_2 AS G1
 LEFT JOIN kfl_production_dbp_msi_data.ts_zb_projekt_gewerk_kostenart_2 AS G2 ON G1.mandant_id = G2.mandant_id AND G1.projekt_nr
        = G2.projekt_nr AND G1.gewerk_id = G2.gewerk_id AND G1.buchung_typ_cd = G2.buchung_typ_cd AND G1.krk_id = G2.krk_id
     AND G1.kostenart_id = G2.kostenart_id;