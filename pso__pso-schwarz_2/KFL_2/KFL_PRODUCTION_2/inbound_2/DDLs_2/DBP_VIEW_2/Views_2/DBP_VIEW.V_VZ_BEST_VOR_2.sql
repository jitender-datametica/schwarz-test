CREATE OR REPLACE VIEW DBP_VIEW.V_VZ_BEST_VOR_2 (
   mandant_id                               COMMENT 'Mandant_2           '
  ,dat_plan                                 COMMENT 'Planungsdatum       '
  ,wup_id                                   COMMENT 'Betrieb'
  ,nb_id                                    COMMENT 'Nebenbetrieb'
  ,gp_id                                    COMMENT 'Kontonummer des Lieferanten bzw. Kreditors'
  ,gp_teilsortiment_id                      COMMENT 'Lieferantenteilsortiment       '
  ,lagerort_id                              COMMENT 'Lagerort '
  ,disponent_id                             COMMENT 'Disponent'
  ,art_id                                   COMMENT 'Artikelnummer       '
  ,dat_best                                 COMMENT 'Bestelltag'
  ,dat_lief                                 COMMENT 'Liefertag  '
  ,bv_quelle_id                             COMMENT 'BV-Quelle '
  ,menge_best_gesamt                        COMMENT 'Bestellmenge gesamt BME      '
  ,menge_best_normal                        COMMENT 'Bestellmenge regulär BME  '
  ,menge_best_bevorratung                   COMMENT 'Bestellmenge Bevorratung BME        '
  ,menge_best_iwt                           COMMENT 'Bestellmenge IWT BME        '
  ,menge_best_werbung                       COMMENT 'Bestellmenge Werbung BME       '
  ,menge_einh_id                            COMMENT 'Bestellmengenheit'
  ,umrech_faktor_best_bme                   COMMENT 'Umrechenfaktor Bestellmengeheit in Basismengeneinheit'
  ,dat_verfuegbarkeit                       COMMENT 'Verfügbarkeitsdatum '
  ,dat_bestandsperiode_ende                 COMMENT 'Datum Ende Bestandsperiod'
  ,bestand                                  COMMENT 'Gelesener Bestand oder ausgerechnet aus Bestandsprojektion '
  ,bestand_werbung                          COMMENT 'Gelesener PromoBestand o.ausgerechnet aus Bestandsprojektion'
  ,bestand_iwt                              COMMENT 'Gelesener IWBestand oder ausgerechnet aus Bestandsprojektion'
  ,reichweite                               COMMENT 'Reichweite '
  ,dat_besdarfsperiode_ende                 COMMENT 'Datum Ende Bedarfsperiode'
  ,bedarf_netto                             COMMENT 'Nettobedarf'
  ,bedarf_erweitert                         COMMENT 'Bedarf erweitert'
  ,bedarf_nach_mbm_art                      COMMENT 'nach MBM Artike'
  ,bedarf_nach_rundung                      COMMENT 'nach Rundung '
  ,bedarf_nach_dyn_rundung                  COMMENT 'nach dynamischer Rundung'
  ,bedarf_nach_mbm_lieferant                COMMENT 'nach MBM Lieferant'
  ,vz_dispo_status_id                       COMMENT 'VZ Dispo Status.'
  ,art_dispo_id                             COMMENT 'Artikel_2 ID DIspo (Surrogate Key). Die art_id entspricht der Artikelnummer aus SAP, ist Business key, während art_dispo_id von SAP täglich neu generiert wird. 
Art_dispo_id ändert sich mit jedem Planungslauf. Art_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '
  ,gp_dispo_id                              COMMENT 'Lieferant ID Dispo (Surrogate Key). Die gp_id entspricht der Lieferantennummer aus SAP, ist Business key, während gp_dispo_id von SAP täglich neu generiert wird. 
Gp_dispo_id ändert sich mit jedem Planungslauf. Gp_dispo_id benötigt man um eine_2 Beziehung zwischen SAP und nicht-SAP Daten herstellen zu können und mit anderen Tabellen joinen zu können. '
  ,best_vor_dispo_id                        COMMENT 'ID des Bestellvorschlags (VZ -> Lieferant). Anmerkung: Dies unterscheidet sich von BEST_VOR_ID (Markt -> VZ).'
)
COMMENT = 'Bestellvorschläge VZ-Lieferant [DC-level order proposals]
'
 AS 
    SELECT 
        mandant_id,
        dat_plan,
        wup_id,
        nb_id,
        gp_id,
        gp_teilsortiment_id,
        lagerort_id,
        disponent_id,
        art_id,
        dat_best,
        dat_lief,
        bv_quelle_id,
        menge_best_gesamt,
        menge_best_normal,
        menge_best_bevorratung,
        menge_best_iwt,
        menge_best_werbung,
        menge_einh_id,
        umrech_faktor_best_bme,
        dat_verfuegbarkeit,
        dat_bestandsperiode_ende,
        bestand,
        bestand_werbung,
        bestand_iwt,
        reichweite,
        dat_besdarfsperiode_ende,
        bedarf_netto,
        bedarf_erweitert,
        bedarf_nach_mbm_art,
        bedarf_nach_rundung,
        bedarf_nach_dyn_rundung,
        bedarf_nach_mbm_lieferant,
        vz_dispo_status_id,
        art_dispo_id,
        gp_dispo_id,
        best_vor_dispo_id

FROM DBP_DATA.VZ_BEST_VOR_2 ;