CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_rueckfuehrung_ladungstraeger_1 (dat_buch, dat_tour,
transportation_unit_id, kj_transportation_unit, nb_id_lager, wup_id_lager, wup_id, mandant_id, wertstoffturm_nr, art_id
, lagerbew_beleg_id, rueck_grund_id, lfnr, ipn_id, menge_bme, anz_stp, vol, positionen) AS SELECT RUECK_LT.dat_buch,
 COALESCE(TOUR.dat_tour, TU_AKT.dat_tour) AS dat_tour_,
 RUECK_LT.tour_id AS transportation_unit_id,
 EXTRACT(YEAR FROM COALESCE(TOUR.dat_tour, TU_AKT.dat_tour)) AS kj_transportation_unit,
 RUECK_LT.nb_id_lager,
 RUECK_LT.wup_id_lager,
 COALESCE(W.aktuell_wup_id, RUECK_LT.wup_id) AS wup_id,
 RUECK_LT.mandant_id,
 RUECK_LT.wertstoffturm_nr,
 RUECK_LT.art_id,
 RUECK_LT.lagerbew_beleg_id,
 RUECK_LT_GR.rueck_grund_id,
 RUECK_LT.lfnr,
 COALESCE(ART.ipn_id, 0) AS ipn_id,
 RUECK_LT.menge_bme,
 RUECK_LT.anz_stp,
 COALESCE(faktor.vol, 0) AS vol,
 CONCAT(RUECK_LT.tour_id, RUECK_LT.wup_id, RUECK_LT.lagerbew_beleg_id, RUECK_LT.lfnr, RUECK_LT.art_id) AS positionen
FROM kfl_production_dbp_view.v_rueckfuehrung_lt_1 AS RUECK_LT
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W ON RUECK_LT.mandant_id = W.mandant_id AND RUECK_LT.wup_id = W.wup_id AND W
   .nb_id = 0
 LEFT JOIN kfl_production_dbp_view.v_rueckfuehrung_lt_grund_1 AS RUECK_LT_GR ON RUECK_LT.mandant_id = RUECK_LT_GR.mandant_id
       AND RUECK_LT.tour_id = RUECK_LT_GR.tour_id AND RUECK_LT.lfnr = RUECK_LT_GR.lfnr AND RUECK_LT.lagerbew_beleg_id =
    RUECK_LT_GR.lagerbew_beleg_id AND RUECK_LT.art_id = RUECK_LT_GR.art_id
 LEFT JOIN kfl_production_dbp_view.v_tour_1 AS TOUR_1 ON RUECK_LT.mandant_id = TOUR.mandant_id AND RUECK_LT.wup_id_lager =
    TOUR.wup_id AND RUECK_LT.tour_id = TOUR.tour_id
 LEFT JOIN kfl_production_dbp_view.v_transportation_unit_aktivitaet_1 AS TU_AKT ON RUECK_LT.tour_id = TU_AKT.transportation_unit_id
     AND RUECK_LT.mandant_id = TU_AKT.mandant_id AND TU_AKT.aktivitaet_richtung_id = '2'
 LEFT JOIN kfl_production_dbp_view.v_art_1 AS ART_1 ON RUECK_LT.art_id = ART.art_id AND RUECK_LT.mandant_id = ART.mandant_id
   
 LEFT JOIN (SELECT V01.mandant_id,
   V01.art_id,
   IF(V02.stellplatz_faktor = 0, NULL, V02.stellplatz_faktor) AS vol
  FROM kfl_production_dbp_view.v_art_1 AS V01
   LEFT JOIN kfl_production_dbp_msi_view_log.ts_art_stellplatz_faktor_1 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id
      = V02.mandant_id
   INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
        AND V03.dat_bis = DATE '9999-12-31' AND V03.arthiertyp_id = 2
   INNER JOIN kfl_production_dbp_view.v_wg_filter_zu_1 AS V04 ON V03.mandant_id = V04.mandant_id AND V03.wg_id = V04.wg_id
       AND V04.wg_filter_id = 4
  WHERE V01.dat_bis = DATE '9999-12-31') AS faktor ON RUECK_LT.art_id = faktor.art_id AND RUECK_LT.mandant_id = faktor.mandant_id
   
WHERE COALESCE(TOUR.dat_tour, TU_AKT.dat_tour) >= DATE '2023-01-01';