CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artbew_promotion_zu_2 (art_id
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
mandant_id OPTIONS(description='Mandant_2 im DWH'), wup_id
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), dat
OPTIONS(description='Datum im Format JJJJ-MM_2-TT '), bonuskauf_id
OPTIONS(description='In SAP vergebene ID, leider nur wahrscheinlich numerisch'), konditionsart_id
OPTIONS(description='Eindeutiger Fachschlüssel der Konditionsart.'), ean_kasse
OPTIONS(description='von den Kassensystemen gelieferte EAN_2'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), betrag_promo_netto
OPTIONS(description='Um die Mehrwertsteuer verminderter Promotionsbetrag'), betrag_mwst
OPTIONS(description='Mehrwertsteuerbetrag des Promotionsbetrags'), umrechnungskurs
OPTIONS(description='Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs_2 angereichert'),
umrechnungskurs_hist OPTIONS(description='Historischer Berichtskurs aus dbp_data.kurs_2 '), system_id
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'), menge_promo
OPTIONS(description='abverkaufte Menge'), umsatz_promo_netto
OPTIONS(description='Um die Mehrwertsteuer verminderter Promotionsumsatz'), umsatz_mwst
OPTIONS(description='Mehrwertsteuerbetrag des Promotionsumsatzes'))
OPTIONS(DESCRIPTION = `AIS_KMO - HIER WERDEN PROMOTIONEN GESPEICHERT - ZUSATZTABELLE ZU ARTBEW_2`) AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat,
 bonuskauf_id,
 konditionsart_id,
 ean_kasse,
 wrg_id,
 betrag_promo_netto,
 betrag_mwst,
 umrechnungskurs,
 umrechnungskurs_hist,
 system_id,
 menge_promo,
 umsatz_promo_netto,
 umsatz_mwst
FROM kfl_production_dbp_data.artbew_promotion_zu_2;