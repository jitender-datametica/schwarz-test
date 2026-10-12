CREATE OR REPLACE VIEW DBP_VIEW.V_ARTBEW_PROMOTION_ZU_2 (
   art_id                                   COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'
  ,mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,wup_id                                   COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,dat                                      COMMENT 'Datum im Format JJJJ-MM_2-TT '
  ,bonuskauf_id                             COMMENT 'In SAP vergebene ID, leider nur wahrscheinlich numerisch'
  ,konditionsart_id                         COMMENT 'Eindeutiger Fachschlüssel der Konditionsart.'
  ,ean_kasse                                COMMENT 'von den Kassensystemen gelieferte EAN_2'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
  ,betrag_promo_netto                       COMMENT 'Um die Mehrwertsteuer verminderter Promotionsbetrag'
  ,betrag_mwst                              COMMENT 'Mehrwertsteuerbetrag des Promotionsbetrags'
  ,umrechnungskurs                          COMMENT 'Umrechnungskurs zur Umrechnung in Euro. Wird aus der Tabelle kurs_2 angereichert'
  ,umrechnungskurs_hist                     COMMENT 'Historischer Berichtskurs aus dbp_data.kurs_2 '
  ,system_id                                COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'
  ,menge_promo                              COMMENT 'abverkaufte Menge'
  ,umsatz_promo_netto                       COMMENT 'Um die Mehrwertsteuer verminderter Promotionsumsatz'
  ,umsatz_mwst                              COMMENT 'Mehrwertsteuerbetrag des Promotionsumsatzes'
)
COMMENT = 'AIS_KMO - Hier werden Promotionen gespeichert - Zusatztabelle zu artbew_2'
 AS 
    SELECT 
        art_id,
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

FROM DBP_DATA.ARTBEW_PROMOTION_ZU_2 ;