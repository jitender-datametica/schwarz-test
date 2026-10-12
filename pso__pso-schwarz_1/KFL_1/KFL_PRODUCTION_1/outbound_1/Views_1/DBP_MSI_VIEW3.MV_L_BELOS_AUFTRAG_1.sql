CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_belos_auftrag_1 (mandant_id, belos_adresse_absender_num_id,
tour_id, tour_id_auftrag, tms) AS SELECT BV.mandant_id,
 BV.belos_adresse_absender_num_id,
 BV.tour_id,
 MAX(CASE
   WHEN BV.tour_id < 0
   THEN BV.transportauftrag_id
   ELSE CAST(CAST(BV.tour_id AS BIGNUMERIC) AS STRING)
   END) AS tour_id_auftrag,
 MAX('BELOS') AS tms
FROM kfl_production_dbp_view.v_belos_vorgang_1 AS BV
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   MIN(dat_tms_wanko) AS dat_tms_wanko
  FROM kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm_1
  WHERE dat_tms_wanko IS NOT NULL
  GROUP BY mandant_id,
   wup_id) AS dw ON BV.mandant_id = dw.mandant_id AND BV.belos_adresse_absender_num_id = dw.wup_id
WHERE BV.belosart_fg = 1
 AND BV.tour_id <= 2147483646
 AND BV.dat_leistung < COALESCE(dw.dat_tms_wanko, DATE '9999-12-31')
GROUP BY BV.mandant_id,
 BV.belos_adresse_absender_num_id,
 BV.tour_id
UNION DISTINCT
SELECT TMS_TOUR.mandant_id,
 ROUND(SAFE_CAST(TMS_TOUR.startlager_tms_gp_id AS BIGNUMERIC), 0) AS belos_adresse_absender_num_id,
 ROUND(SAFE_CAST(RIGHT(TMS_TOUR.transportation_unit_id_ext, LENGTH(TRIM(TMS_TOUR.transportation_unit_id_ext)) - 6) AS BIGNUMERIC), 0) AS tour_id,
 MAX(CASE
   WHEN TMS_TOUR.tms_tourart_detail_id IN (4, 5)
   THEN TMS_TOUR.tms_tour_bez
   ELSE CAST(ROUND(SAFE_CAST(RIGHT(TMS_TOUR.transportation_unit_id_ext, LENGTH(TRIM(TMS_TOUR.transportation_unit_id_ext)) - 6) AS BIGNUMERIC), 0) AS STRING)
   END) AS tour_id_auftrag,
 MAX('WANKO') AS tms
FROM kfl_production_dbp_view.v_tms_tour_1 AS TMS_TOUR_1
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   MIN(dat_tms_wanko) AS dat_tms_wanko
  FROM kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm_1
  WHERE dat_tms_wanko IS NOT NULL
  GROUP BY mandant_id,
   wup_id) AS dw ON TMS_TOUR.mandant_id = dw.mandant_id AND dw.wup_id = ROUND(SAFE_CAST(TMS_TOUR.startlager_tms_gp_id AS BIGNUMERIC), 0)
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   MIN(dat) AS dat
  FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_1
  GROUP BY mandant_id,
   wup_id) AS ewm ON TMS_TOUR.mandant_id = ewm.mandant_id AND ewm.wup_id = ROUND(SAFE_CAST(TMS_TOUR.startlager_tms_gp_id AS BIGNUMERIC), 0)
WHERE TMS_TOUR.dat_tour >= COALESCE(dw.dat_tms_wanko, DATE '9999-12-31')
 AND TMS_TOUR.dat_tour < COALESCE(ewm.dat, DATE '9999-12-31')
GROUP BY TMS_TOUR.mandant_id,
 belos_adresse_absender_num_id,
 tour_id;