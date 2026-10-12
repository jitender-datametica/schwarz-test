CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_art_gp_korrektur_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
wup_id OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), art_id
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
dat_vk OPTIONS(description='Verkaufsdatum der Artikel_2 in der Filiale.'), dat_korrektur
OPTIONS(description='Datum, an dem die Korrektur identifziert und durchgeführt wurde.'), gp_alt_id
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID) vor der Korrektur. Bei GP_ID = 0 handelt es sich um so genannte VK_2-Sets und bedeutet, dass dieser Artikel_2 aus mehreren anderen Artikeln von unterschiedlichen GPs besteht.'),
gp_neu_id
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID) nach der Korrektur. Bei GP_ID = 0 handelt es sich um so genannte VK_2-Sets und bedeutet, dass dieser Artikel_2 aus mehreren anderen Artikeln von unterschiedlichen GPs besteht.'),
bq_findung_alt_id
OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess vor der Korrektur.'),
bq_findung_neu_id
OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess nach der Korrektur.'), menge_vk_bme
OPTIONS(description='Verkaufte Menge des Artikels in der Filiale (kann in Stück oder bei Gewichtsartikeln in KG sein). Anzahl der abverkauften Artikel_2 reduziert um zurückgegebene Artikel.'),
betrag_umsatz_netto
OPTIONS(description='Erwirtschafteter Umsatz des Artikels in der Filiale vermindert um den Mehrwertsteuerbetrag.'),
betrag_ek_netto_alt
OPTIONS(description='Netto Rechnungs-Einkaufspreis der verkaufen Menge des Artikels in der Filiale vor der Korrektur (menge_vk * ek_netto).'),
betrag_ek_netto_neu
OPTIONS(description='Netto Rechnungs-Einkaufspreis der verkauften Menge des Artikels in der Filiale nach der Korrektur (menge_vk * ek_netto).'),
betrag_ek_mep_alt
OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema) der verkauften Menge des Artikels in der Filiale vor der Korrektur (menge_vk * ek_mep).'),
betrag_ek_mep_neu
OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema) der verkauften Menge des Artikels in der Filiale nach der Korrektur (menge_vk * ek_mep).'))
OPTIONS(DESCRIPTION = `ES KANN VORKOMMEN, DAS ARTIKEL_2 - LIEFERANTEN VERBINDUNGEN FÜR DIE FILIALEN RÜCKWIRKEND GEÄNDERT WERDEN.MIT DIESER TABELLE SOLLEN DIESE ÄNDERUNGEN SICHTBAR GEMACHT UND FÜR DAS REPORTING GENUTZT WERDEN.`)
AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 dat_vk,
 dat_korrektur,
 gp_alt_id,
 gp_neu_id,
 bq_findung_alt_id,
 bq_findung_neu_id,
 menge_vk_bme,
 betrag_umsatz_netto,
 betrag_ek_netto_alt,
 betrag_ek_netto_neu,
 betrag_ek_mep_alt,
 betrag_ek_mep_neu
FROM kfl_production_dbp_data.wup_art_gp_korrektur_2;