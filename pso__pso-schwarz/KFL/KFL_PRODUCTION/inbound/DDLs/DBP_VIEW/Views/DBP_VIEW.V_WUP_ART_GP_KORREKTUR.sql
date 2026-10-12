CREATE OR REPLACE VIEW DBP_VIEW.V_WUP_ART_GP_KORREKTUR (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,wup_id                                   COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,art_id                                   COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'
  ,dat_vk                                   COMMENT 'Verkaufsdatum der Artikel in der Filiale.'
  ,dat_korrektur                            COMMENT 'Datum, an dem die Korrektur identifziert und durchgeführt wurde.'  
  ,gp_alt_id                                COMMENT 'Geschäftspartner - ID (Lieferanten - ID) vor der Korrektur. Bei GP_ID = 0 handelt es sich um so genannte VK-Sets und bedeutet, dass dieser Artikel aus mehreren anderen Artikeln von unterschiedlichen GPs besteht.'
  ,gp_neu_id                                COMMENT 'Geschäftspartner - ID (Lieferanten - ID) nach der Korrektur. Bei GP_ID = 0 handelt es sich um so genannte VK-Sets und bedeutet, dass dieser Artikel aus mehreren anderen Artikeln von unterschiedlichen GPs besteht.'
  ,bq_findung_alt_id                        COMMENT 'ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess vor der Korrektur.'
  ,bq_findung_neu_id                        COMMENT 'ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess nach der Korrektur.'
  ,menge_vk_bme                             COMMENT 'Verkaufte Menge des Artikels in der Filiale (kann in Stück oder bei Gewichtsartikeln in KG sein). Anzahl der abverkauften Artikel reduziert um zurückgegebene Artikel.'
  ,betrag_umsatz_netto                      COMMENT 'Erwirtschafteter Umsatz des Artikels in der Filiale vermindert um den Mehrwertsteuerbetrag.'
  ,betrag_ek_netto_alt                      COMMENT 'Netto Rechnungs-Einkaufspreis der verkaufen Menge des Artikels in der Filiale vor der Korrektur (menge_vk * ek_netto).'
  ,betrag_ek_netto_neu                      COMMENT 'Netto Rechnungs-Einkaufspreis der verkauften Menge des Artikels in der Filiale nach der Korrektur (menge_vk * ek_netto).'
  ,betrag_ek_mep_alt                        COMMENT 'Markteinstandspreis (Bedeutung vgl. Kalkulationsschema) der verkauften Menge des Artikels in der Filiale vor der Korrektur (menge_vk * ek_mep).'
  ,betrag_ek_mep_neu                        COMMENT 'Markteinstandspreis (Bedeutung vgl. Kalkulationsschema) der verkauften Menge des Artikels in der Filiale nach der Korrektur (menge_vk * ek_mep).'
)
COMMENT = 'Es kann vorkommen, das Artikel - Lieferanten Verbindungen für die Filialen rückwirkend geändert werden.Mit dieser Tabelle sollen diese Änderungen sichtbar gemacht und für das Reporting genutzt werden.'
 AS 
    SELECT 
        mandant_id,
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

FROM DBP_DATA.WUP_ART_GP_KORREKTUR ;