--==============================================================
-- Table: wup_art_gp_korrektur_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_art_gp_korrektur_2
   generated from Powerdesigner on Dienstag, 15. Oktober 2024 11:06:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_art_gp_korrektur_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.'),
dat_vk DATE NOT NULL OPTIONS(description='Verkaufsdatum der Artikel_2 in der Filiale.'),
dat_korrektur DATE NOT NULL OPTIONS(description='Datum, an dem die Korrektur identifziert und durchgeführt wurde.'),
gp_alt_id BIGNUMERIC(38,0)
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID) vor der Korrektur. Bei GP_ID = 0 handelt es sich um so genannte VK_2-Sets und bedeutet, dass dieser Artikel_2 aus mehreren anderen Artikeln von unterschiedlichen GPs besteht.'),
gp_neu_id BIGNUMERIC(38,0)
OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID) nach der Korrektur. Bei GP_ID = 0 handelt es sich um so genannte VK_2-Sets und bedeutet, dass dieser Artikel_2 aus mehreren anderen Artikeln von unterschiedlichen GPs besteht.'),
bq_findung_alt_id BIGNUMERIC(38,0)
OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess vor der Korrektur.'),
bq_findung_neu_id BIGNUMERIC(38,0)
OPTIONS(description='ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess nach der Korrektur.'),
menge_vk_bme BIGNUMERIC(38,3)
OPTIONS(description='Verkaufte Menge des Artikels in der Filiale (kann in Stück oder bei Gewichtsartikeln in KG sein). Anzahl der abverkauften Artikel_2 reduziert um zurückgegebene Artikel.'),
betrag_umsatz_netto BIGNUMERIC(38,4)
OPTIONS(description='Erwirtschafteter Umsatz des Artikels in der Filiale vermindert um den Mehrwertsteuerbetrag.'),
betrag_ek_netto_alt BIGNUMERIC(38,4)
OPTIONS(description='Netto Rechnungs-Einkaufspreis der verkaufen Menge des Artikels in der Filiale vor der Korrektur (menge_vk * ek_netto).'),
betrag_ek_netto_neu BIGNUMERIC(38,4)
OPTIONS(description='Netto Rechnungs-Einkaufspreis der verkauften Menge des Artikels in der Filiale nach der Korrektur (menge_vk * ek_netto).'),
betrag_ek_mep_alt BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema) der verkauften Menge des Artikels in der Filiale vor der Korrektur (menge_vk * ek_mep).'),
betrag_ek_mep_neu BIGNUMERIC(38,4)
OPTIONS(description='Markteinstandspreis (Bedeutung vgl. Kalkulationsschema) der verkauften Menge des Artikels in der Filiale nach der Korrektur (menge_vk * ek_mep).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_vk, dat_korrektur) NOT ENFORCED
)
OPTIONS(description='Es kann vorkommen, das Artikel_2 - Lieferanten Verbindungen für die Filialen rückwirkend geändert werden.Mit dieser Tabelle sollen diese Änderungen sichtbar gemacht und für das Reporting genutzt werden.');