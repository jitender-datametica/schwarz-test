CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_rueckfuehrung_landungstrager (dat_buch, dat_tour,
transportation_unit_id, nb_id_lager, wup_id_lager, wup_id, mandant_id, wertstoffturm_nr, art_id, lagerbew_beleg_id,
rueck_grund_id, lfnr, ipn_id, menge_bme, anz_stp, vol, positionen) AS SELECT RUECK_LT.dat_buch,
 COALESCE(TOUR.dat_tour, TU_AKT.dat_tour) AS dat_tour,
 RUECK_LT.tour_id AS transportation_unit_id,
 RUECK_LT.nb_id_lager,
 RUECK_LT.wup_id_lager,
 RUECK_LT.wup_id,
 RUECK_LT.mandant_id,
 RUECK_LT.wertstoffturm_nr,
 RUECK_LT.art_id,
 RUECK_LT.lagerbew_beleg_id,
 RUECK_LT_GR.rueck_grund_id,
 RUECK_LT.lfnr,
 ART.ipn_id,
 RUECK_LT.menge_bme,
 RUECK_LT.anz_stp,
 faktor.vol,
 CONCAT(RUECK_LT.tour_id, RUECK_LT.wup_id, RUECK_LT.lagerbew_beleg_id, RUECK_LT.lfnr, RUECK_LT.art_id) AS positionen
FROM kfl_production_dbp_view.v_rueckfuehrung_lt AS RUECK_LT
 LEFT JOIN kfl_production_dbp_view.v_rueckfuehrung_lt_grund AS RUECK_LT_GR ON RUECK_LT.mandant_id = RUECK_LT_GR.mandant_id
       AND RUECK_LT.tour_id = RUECK_LT_GR.tour_id AND RUECK_LT.lfnr = RUECK_LT_GR.lfnr AND RUECK_LT.lagerbew_beleg_id =
    RUECK_LT_GR.lagerbew_beleg_id AND RUECK_LT.art_id = RUECK_LT_GR.art_id
 LEFT JOIN kfl_production_dbp_view.v_tour AS TOUR ON RUECK_LT.wup_id_lager = TOUR.wup_id AND RUECK_LT.mandant_id = TOUR
    .mandant_id AND RUECK_LT.tour_id = TOUR.tour_id
 LEFT JOIN kfl_production_dbp_view.v_transportation_unit_aktivitaet AS TU_AKT ON RUECK_LT.tour_id = TU_AKT.transportation_unit_id
     AND RUECK_LT.mandant_id = TU_AKT.mandant_id AND CAST(TU_AKT.aktivitaet_richtung_id AS FLOAT64) = 2
 LEFT JOIN kfl_production_dbp_view.v_art AS ART ON RUECK_LT.art_id = ART.art_id AND RUECK_LT.mandant_id = ART.mandant_id
   
 LEFT JOIN (SELECT V01.mandant_id,
   V01.art_id,
   IF(V02.stellplatz_faktor = 0, NULL, V02.stellplatz_faktor) AS vol
  FROM kfl_production_dbp_view.v_art AS V01
   LEFT JOIN kfl_production_dbp_msi_view_log.ts_art_stellplatz_faktor AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id
      = V02.mandant_id
   INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS V03 ON V01.mandant_id = V03.mandant_id AND V01.art_id = V03.art_id
     
  WHERE V01.dat_bis = DATE '9999-12-31'
   AND V03.wg_id IN (980, 981, 982, 983)) AS faktor ON RUECK_LT.art_id = faktor.art_id AND RUECK_LT.mandant_id = faktor
   .mandant_id;