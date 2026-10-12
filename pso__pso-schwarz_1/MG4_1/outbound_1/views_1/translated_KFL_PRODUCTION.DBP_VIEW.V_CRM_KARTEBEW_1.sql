CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_kartebew_1 (mandant_id OPTIONS(description='Mandant_1 im DWH.'), wup_id
OPTIONS(description='Mutter Wup_1 ID wird verwendet fur Beziehung Lager zu Verteilzentrum.'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.'), kundenkarte_id
OPTIONS(description='Nummer der Kundenkarte / Bonuskarte (gehasht), kann gemappt werden mit ods_bon_kopf.kundenkarte_id.'),
dat OPTIONS(description='Datum im Format JJJJ-MM_1-TT.'), loyalty_berechtigt_fg
OPTIONS(description='Gibt an, ob CRM Promotion gewährt wurde. 1 = ja; 0 = nein. Ab 01.03.2025 wird das Flag aus ods_bon_kopf_1 berechnet. (Logik für alte Daten folgt)'),
wrg_id OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'), umsatz_netto_sa
OPTIONS(description='SA Umsatz vermindert um den Mehrwertsteuerbetrag.'), umsatz_netto_af
OPTIONS(description='AF Umsatz vermindert um den Mehrwertsteuerbetrag.'), umsatz_brutto_sa
OPTIONS(description='SA Umsatz.'), umsatz_brutto_af OPTIONS(description='AF Umsatz.'), anz_bons
OPTIONS(description='Bons, die eine_1 Kundenkarte generiert.')) AS SELECT mandant_id,
 wup_id,
 nb_id,
 kundenkarte_id,
 dat,
 loyalty_berechtigt_fg,
 wrg_id,
 umsatz_netto_sa,
 umsatz_netto_af,
 umsatz_brutto_sa,
 umsatz_brutto_af,
 anz_bons
FROM kfl_production_dbp_data.crm_kartebew_1;