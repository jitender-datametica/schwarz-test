CREATE OR REPLACE VIEW DBP_VIEW.V_ARTBEW_STUECKLISTE_ZU_2 (
   art_id                                   COMMENT 'ID der Artikelnummer per Stueckliste_2 mit Referenz zur Tabelle art_2'
  ,mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,wup_id                                   COMMENT 'Nummer des Marktes'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,dat                                      COMMENT 'Datum des Abverkaufs, Format YYYY-MM_2-DD'
  ,komponente_art_id                        COMMENT 'Artikelnummer der Stuecklistenkomponente mit referenz zur Tabelle art_2'
  ,umrech_faktor                            COMMENT 'Umrechnungsfaktor für die Komponenten in einem VK_2-Set.'
  ,menge_komponente_in_vk_set               COMMENT 'Gewichstwert in der Mengeneinheit der Komponente in der Stückliste bzw. Verkaufsset (VK_2-Set) anteilig ihrer Menge.'
  ,stueckliste_id                           COMMENT 'Eindeutige ID der Stueckliste_2'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'
  ,umsatz_netto                             COMMENT 'Umsatz vermindert um den Mehrwertsteuerbetrag. Anteil aus Abverkauf auf Basis EKN1'
  ,umsatz_mwst_betrag                       COMMENT 'Der Mehrwertsteuerbetrag wird hier redundant abgelegt. Er ist eigentlich pro Artikel_2 als Mehrwertsteuersatz im Artikelstamm ersichtlich muss aber hier aus Performancegründen auch stehen.'
  ,menge                                    COMMENT 'berechneter Wert aus Menge Abverkauf * Menge Komponente * Umrechnungsfaktor'
  ,ek_brutto                                COMMENT 'Einkaufspreis brutto (bedeutung vgl. Kalkulationsschema).'
  ,ek_netto                                 COMMENT 'Einkaufspreis netto (bedeutung vgl. Kalkulationsschema).'
  ,ek_nettonetto                            COMMENT 'Einkaufspreis nettonetto ((Bedeutung vgl. Kalkulationsschema).'
  ,ek_kal_basis                             COMMENT 'Kalkulationsbasis ((Bedeutung vgl. Kalkulationsschema).'
  ,ek_mep                                   COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema).'
  ,ek_mep_vor_fwu                           COMMENT 'Markteinstandspreis vor Festwertumlage: Mit Einführung der Festwertumlage in KMO braucht es einen "alten" EK3Netto ohne die Festwertumlage als Vergleichswert. Dieser Wert wird aus SAP über ZEKP.MEPOL geliefert.'
  ,einstandspreis                           COMMENT 'Kaufland Einstandspreis ((Bedeutung vgl. Kalkulationsschema).'
  ,logkostenzuschlag                        COMMENT 'Logistikkostenzuschlag (ein kalkulierter Wert, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist)'
  ,ek_netto_bnk                             COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).'
  ,ek_netto_bnk_sachk                       COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten plus Sachkosten(Bedeutung vgl. Kalkulationsschema).'
  ,bq_findung_id                            COMMENT 'ID zur Kennzeichnung eines Ausstiegspunkts aus dem Kreisprozess.'
  ,umrechnungskurs                          COMMENT 'Umrechnungskurs zur Umrechnung Landeswährung in Euro. Wird aus der Tabelle kurs_2 angereichert'
  ,umrechnungskurs_hist                     COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_2 '
  ,bonusbasis                               COMMENT 'Die Bonusbasis bildet für Artikel_2 mit Luxussteuer die Preisbasis der Reduzierungen nach Abzug der Luxussteuer auf der Ebene EK1N. Quelle: ZEKP.ABONBA'
)
COMMENT = 'AIS KMO - Hier werden die Stuecklistenartikel aus artbew_2 in ihre Positionen aufgeloest, um diese detailliert auswerten zu koennen.'
 AS 
    SELECT 
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        dat,
        komponente_art_id,
        umrech_faktor,
        menge_komponente_in_vk_set,
        stueckliste_id,
        wrg_id,
        umsatz_netto,
        umsatz_mwst_betrag,
        menge,
        ek_brutto,
        ek_netto,
        ek_nettonetto,
        ek_kal_basis,
        ek_mep,
        ek_mep_vor_fwu,
        einstandspreis,
        logkostenzuschlag,
        ek_netto_bnk,
        ek_netto_bnk_sachk,
        bq_findung_id,
        umrechnungskurs,
        umrechnungskurs_hist,
        bonusbasis

FROM DBP_DATA.ARTBEW_STUECKLISTE_ZU_2 ;