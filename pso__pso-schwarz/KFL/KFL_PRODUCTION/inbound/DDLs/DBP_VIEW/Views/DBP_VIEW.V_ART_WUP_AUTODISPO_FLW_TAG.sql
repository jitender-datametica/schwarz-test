CREATE OR REPLACE VIEW DBP_VIEW.V_ART_WUP_AUTODISPO_FLW_TAG (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,kunde_id                                 COMMENT 'Marktnummer'
  ,wup_id                                   COMMENT 'Lieferndes VZ o. dezentraler Lieferant'
  ,nb_id_kunde                              COMMENT 'Nebenbetrieb Markt (0)'
  ,nb_id_lieferant                          COMMENT 'Nebenbetrieb Lieferndes VZ o. dezentraler Lieferant (-111)'
  ,art_id                                   COMMENT 'Artikel'
  ,dat                                      COMMENT 'Datum'
  ,menge_einh_id                            COMMENT 'Mengeneinheit der Kennzahlen - für DE Fleisch BME, KG, KOL, ST, EUR - Rest nur Basismengeneinheit (BME)'
  ,we_bearbeitungszeit                      COMMENT 'Bearbeitungszeit Wareneingang in Tagen'
  ,planlieferzeit                           COMMENT 'Planlieferzeit in Tagen'
  ,kdis                                     COMMENT 'Flag: kDiS oder DiS (Bestelllistung)'
  ,verkaufslistung_fg                       COMMENT 'Flag: Verkaufslistung (Bestelllistung + X Tage)'
  ,sa_af_fg                                 COMMENT 'Flag: Sonderaktion oder Aktionsfrei'
  ,udf_prognose_menge_gesteuert             COMMENT 'SAP UDF-Prognose (gesteuert)'
  ,udf_prognose_menge_ungesteuert           COMMENT 'SAP UDF-Prognose (ungesteuert)'
  ,fur_prognose_menge_ungesteuert           COMMENT 'SAP F&R-Prognose (ungesteuert)'
  ,fur_prognose_menge_gesteuert             COMMENT 'SAP F&R-Prognose (gesteuert)'
  ,fur_prognose_menge_max                   COMMENT 'SAP F&R-Prognose (max)'
  ,menge_abverkauf                          COMMENT 'Abverkaufte Menge'
  ,ret_bestand                              COMMENT 'Frei verfügbarer Bestand im Markt (SAP Retail)'
  ,fur_bestand                              COMMENT 'Bestand im Markt (SAP F&R)'
  ,menge_we_offen                           COMMENT 'Offener Wareneingang (Bestellungen ohne Endlieferkenzeichen)'
  ,menge_bv                                 COMMENT 'Menge Bestellvorschlag'
  ,menge_ofc                                COMMENT 'Menge Order Forecast'
  ,nullbestand_fg                           COMMENT 'Flag: Nullbestand im Markt (F&R Bestand <= 0)'
  ,menge_preisabschriften                   COMMENT 'Menge Preisabschriften'
  ,menge_totalabschriften                   COMMENT 'Menge Totalabschriften'
  ,kollifaktor                              COMMENT 'Kollifaktor'
  ,egalisierungsfaktor                      COMMENT 'Egalisierungsfaktor (=Packungsinhalt)'
  ,servicelevel                             COMMENT 'Servicelevel'
  ,optik                                    COMMENT 'Optik'
  ,menge_we                                 COMMENT 'Menge Wareneingang (gebuchter WE)'
  ,nullbestand_exc_fg                       COMMENT 'Flag: Nullbestand im Markt (Exception 209)'
  ,menge_we_geplant                         COMMENT 'Geplanter Wareneingang. Berechnungslogik: 
- wenn Bestelltag < Heute dann menge_we
- wenn Bestelltag = Heute dann menge_we_offen
- wenn Bestelltag > Heute dann menge_ofc + menge_we_offen
Offener Wareneingang aus SAP RET EKPO; Order Forecast für Liefertag aus ZFRE_OFC'
  ,display_art_id                           COMMENT 'Artikel-ID des Displays im Lagerbewegungsbeleg. Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel aufgeführt. Ein Display ist beispielsweise eine fertig gebaute Palette von Mondelez, die mehrere Sorten Milka Schokolade enthält und an den Markt geliefert wird. Über diese Spalte bekommen die Komponenten die art_id des zugehörigen Displays. Wird bei der Beladung gefüllt.'
  ,komponentenmenge                         COMMENT 'Gibt an, wie viele Einheiten einer bestimmten Sorte (Komponente) in einem Display enthalten sind. Für die Komponenten selbst wird hier die jeweilige Einzelmenge erfasst. Für das Display (DP) wird die Summe aller enthaltenen  Aus stueckliste_det befüllt'
)
COMMENT = 'Tabelle enthält Artikel/Markt/Tag Kombinationen auf Autodispo - Grundgesamtheit bildet für Fleischartikel in DE der EK Ordersatz (EORD), für den Rest die Tabelle ZE1WBB06 (beide SAP RET).'
 AS 
    SELECT 
        mandant_id,
        kunde_id,
        wup_id,
        nb_id_kunde,
        nb_id_lieferant,
        art_id,
        dat,
        menge_einh_id,
        we_bearbeitungszeit,
        planlieferzeit,
        kdis,
        verkaufslistung_fg,
        sa_af_fg,
        udf_prognose_menge_gesteuert,
        udf_prognose_menge_ungesteuert,
        fur_prognose_menge_ungesteuert,
        fur_prognose_menge_gesteuert,
        fur_prognose_menge_max,
        menge_abverkauf,
        ret_bestand,
        fur_bestand,
        menge_we_offen,
        menge_bv,
        menge_ofc,
        nullbestand_fg,
        menge_preisabschriften,
        menge_totalabschriften,
        kollifaktor,
        egalisierungsfaktor,
        servicelevel,
        optik,
        menge_we,
        nullbestand_exc_fg,
        menge_we_geplant,
        display_art_id,
        komponentenmenge

FROM DBP_DATA.ART_WUP_AUTODISPO_FLW_TAG ;