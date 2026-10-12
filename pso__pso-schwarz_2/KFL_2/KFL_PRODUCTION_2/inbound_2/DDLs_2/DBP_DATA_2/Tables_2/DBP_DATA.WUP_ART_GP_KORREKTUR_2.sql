--==============================================================
-- Table: wup_art_gp_korrektur_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_art_gp_korrektur_2
   generated from Powerdesigner on Dienstag, 15. Oktober 2024 11:06:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WUP_ART_GP_KORREKTUR_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   dat_vk                              DATE             NOT NULL COMMENT 'Verkaufsdatum der Artikel_2 in der Filiale.',
   dat_korrektur                       DATE             NOT NULL COMMENT 'Datum, an dem die Korrektur identifziert und durchgeführt wurde.',
   gp_alt_id                           NUMBER(38,0)     COMMENT 'Geschäftspartner - ID (Lieferanten - ID) vor der Korrektur. Bei GP_ID = 0 handelt es sich um so genannte VK_2-Sets und bedeutet, dass dieser Artikel_2 aus mehreren anderen Artikeln von unterschiedlichen GPs besteht.',
   gp_neu_id                           NUMBER(38,0)     COMMENT 'Geschäftspartner - ID (Lieferanten - ID) nach der Korrektur. Bei GP_ID = 0 handelt es sich um so genannte VK_2-Sets und bedeutet, dass dieser Artikel_2 aus mehreren anderen Artikeln von unterschiedlichen GPs besteht.',
   bq_findung_alt_id                   NUMBER(38,0)     COMMENT 'ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess vor der Korrektur.',
   bq_findung_neu_id                   NUMBER(38,0)     COMMENT 'ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess nach der Korrektur.',
   menge_vk_bme                        NUMBER(38,3)     COMMENT 'Verkaufte Menge des Artikels in der Filiale (kann in Stück oder bei Gewichtsartikeln in KG sein). Anzahl der abverkauften Artikel_2 reduziert um zurückgegebene Artikel.',
   betrag_umsatz_netto                 NUMBER(38,4)     COMMENT 'Erwirtschafteter Umsatz des Artikels in der Filiale vermindert um den Mehrwertsteuerbetrag.',
   betrag_ek_netto_alt                 NUMBER(38,4)     COMMENT 'Netto Rechnungs-Einkaufspreis der verkaufen Menge des Artikels in der Filiale vor der Korrektur (menge_vk * ek_netto).',
   betrag_ek_netto_neu                 NUMBER(38,4)     COMMENT 'Netto Rechnungs-Einkaufspreis der verkauften Menge des Artikels in der Filiale nach der Korrektur (menge_vk * ek_netto).',
   betrag_ek_mep_alt                   NUMBER(38,4)     COMMENT 'Markteinstandspreis (Bedeutung vgl. Kalkulationsschema) der verkauften Menge des Artikels in der Filiale vor der Korrektur (menge_vk * ek_mep).',
   betrag_ek_mep_neu                   NUMBER(38,4)     COMMENT 'Markteinstandspreis (Bedeutung vgl. Kalkulationsschema) der verkauften Menge des Artikels in der Filiale nach der Korrektur (menge_vk * ek_mep).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WUP_ART_GP_KORREKTUR PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_vk, dat_korrektur) NOT ENFORCED
)  COMMENT = 'Es kann vorkommen, das Artikel_2 - Lieferanten Verbindungen für die Filialen rückwirkend geändert werden.Mit dieser Tabelle sollen diese Änderungen sichtbar gemacht und für das Reporting genutzt werden.';
