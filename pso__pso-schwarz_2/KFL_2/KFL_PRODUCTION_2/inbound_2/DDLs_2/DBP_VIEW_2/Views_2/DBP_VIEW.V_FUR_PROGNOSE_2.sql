CREATE OR REPLACE VIEW DBP_VIEW.V_FUR_PROGNOSE_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,wup_id                                   COMMENT 'Marktnummer'
  ,nb_id                                    COMMENT ' Nebenbetriebskennziffer'
  ,art_id                                   COMMENT 'DWH-Artikelnummer'
  ,dat                                      COMMENT 'Prognosedatumim Format JJJJ-MM_2-TT'
  ,menge_prognose                           COMMENT 'Normalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_mean '
  ,menge_prognose_bef                       COMMENT 'Normalprognosemenge  in Basismengeneinheit verändert um den BEF (Bedarfseinflussfaktor)  aus dem Quellfeld fc_dif_effect'
  ,menge_prognose_max                       COMMENT 'Maximalprognosemenge in Basismengeneinheit  aus dem Quellfeld fc_max'
  ,listung_id                               COMMENT 'kennzeichnet die Zulistung eines Artikels zum Markt: 1 = gelistet, 0 = nicht mehr gelistet. Denormalisiert - aus art_wup_zu_per_2 angereichert'
  ,kdis                                     COMMENT 'kdis = kein Druck in Sortimentsliste. Kennzeichnet die Bestellbarkeit eines Artikels. kdis 0: der Artikel_2 ist über den normalen Weg bestellbar, 1: der Artikel_2 wird  zugeteilt'
  ,dispomerkmal                             COMMENT 'Dispomerkmal. Denormalisiert aus der Tabelle art_wup_status_per. Referenz zur Lookuptabelle l_dispomerkmal_2'
  ,progn_groesser_fg                        COMMENT 'menge_prognose ist größer als die menge_af in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)'
  ,menge_af_groesser_fg                     COMMENT 'menge_af ist größer als die menge_prognose in bestimmten Verhältnissen zur menge_af (unter Berücksichtigung von Toleranzen)'
  ,menge_prognose_aktion                    COMMENT 'Prognostizierte Aktionsmenge. Wird vorläufig nur gefüllt sein für Backshop-Artikel_2 (WG 291), wenn sie in Aktion_2 sind. Aus der Quellspalte fc_act'
  ,prognose_horizont                        COMMENT 'Prognosehorizont: für wie viele Tage gab es prognostizierte Mengen (wie viele Felder von ZFRE_DWH_FCST.menge_01 bis menge_35 waren gefüllt)'
  ,menge_ofc                                COMMENT 'Menge OF'
)
COMMENT = 'AIS - Hier werden die prognostizierten Abverkaufsmengen aus SAP F&R für 35 Tage im Voraus und mehrere Jahre historisch gespeichert'
 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        dat,
        menge_prognose,
        menge_prognose_bef,
        menge_prognose_max,
        listung_id,
        kdis,
        dispomerkmal,
        progn_groesser_fg,
        menge_af_groesser_fg,
        menge_prognose_aktion,
        prognose_horizont,
        menge_ofc

FROM DBP_DATA.FUR_PROGNOSE_2 ;