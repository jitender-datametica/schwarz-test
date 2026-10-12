CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_sendung_1 (mandant_id, belos_vorgang_id, komplettlieferung_fg,
loesch_fg, in_time_fg, av_fg, distribution_abr_fg, sammel_ladung_fg, nb_id, sendung_gew_einh_id, sendung_vol_einh_id,
dat_lief_soll, dat_zustellung, sendung_id, wup_id, lagerort_id, hgp_id, gewicht_sendung, zustellart_id,
belos_vorgangart_id, transportauftrag_id, sonderabwicklung_id, belos_adresse_absender_num_id, belos_adresse_abholung_id
, belos_adresse_empfaenger_id, belos_adresse_empf_num_id, belos_adresse_spedition_id, vol_stauraum, debitor_id,
anz_unterverpackung, unterverpackung_menge_einh_id, tour_id, tour_id_auftrag, leergut_abh_fg, retouren_fg,
industrie_abh_fg, lagernummer_id, anz_stellplatz_sap, anz_kolli, anz_stellplatz, mandant_id_debitor) AS SELECT V01.mandant_id
 ,
 V01.belos_vorgang_id,
 V01.komplettlieferung_fg,
 V01.loesch_fg,
 V01.in_time_fg,
 V01.av_fg,
 V01.distribution_abr_fg,
 V01.sammel_ladung_fg,
 V01.nb_id,
 V01.sendung_gew_einh_id,
 V01.sendung_vol_einh_id,
 V01.dat_leistung AS dat_lief_soll,
 V01.dat_zustellung,
 V01.sendung_id,
  CASE
  WHEN V01.wup_id = 0 AND V01.belos_adresse_empfaenger_id = 'DCKP'
  THEN 9994
  WHEN V01.wup_id = 0 AND LEFT(V01.belos_adresse_empfaenger_id, 2) = 'DC'
  THEN ROUND(SAFE_CAST(RIGHT(V01.belos_adresse_empfaenger_id, 4) AS BIGNUMERIC), 0)
  ELSE COALESCE(V05.aktuell_wup_id, V01.wup_id)
  END AS wup_id,
 V01.lagerort_id,
 V01.gp_id AS hgp_id,
 V01.brtgew_sendung AS gewicht_sendung,
 V01.zustellart_id,
 V01.belos_vorgangart_id,
 V01.transportauftrag_id,
 V01.sonderabwicklung_id,
 V01.belos_adresse_absender_num_id,
 COALESCE(V01.belos_adresse_abholung_id, V02.belos_adresse_id) AS belos_adresse_abholung_id,
 COALESCE(CAST(V05.aktuell_wup_id AS STRING), V01.belos_adresse_empfaenger_id) AS belos_adresse_empfaenger_id,
 COALESCE(V04.belos_adresse_num_id, V03.belos_adresse_num_id) AS belos_adresse_empf_num_id,
 V01.belos_adresse_spedition_id,
 V01.brtvol_stauraum AS vol_stauraum,
 V01.debitor_id,
 V01.anz_unterverpackung,
 V01.unterverpackung_menge_einh_id,
 V01.tour_id,
  CASE
  WHEN V01.tour_id < 0
  THEN ROUND(SAFE_CAST(V01.transportauftrag_id AS BIGNUMERIC), 0)
  WHEN V01.tour_id <= 2147483646
  THEN CAST(V01.tour_id AS BIGNUMERIC)
  ELSE NULL
  END AS tour_id_auftrag,
 V01.leergut_abh_fg,
 V01.retouren_fg,
 V01.industrie_abh_fg,
 V01.lagernummer_id,
 V01.anz_stellplatz AS anz_stellplatz_sap,
 V01.anz_kolli,
 CAST(COALESCE(V01.anz_stellplatz_belos, V01.anz_stellplatz) AS NUMERIC) AS anz_stellplatz,
 V01.mandant_id_debitor
FROM kfl_production_dbp_view.v_belos_vorgang_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON V05.mandant_id = CASE
     WHEN V01.mandant_id_debitor IS NULL OR V01.mandant_id_debitor = 0
     THEN V01.mandant_id
     ELSE V01.mandant_id_debitor
     END AND V05.wup_id = CASE
     WHEN ROUND(SAFE_CAST(V01.belos_adresse_empfaenger_id AS BIGNUMERIC), 0) = 0
     THEN NULL
     ELSE ROUND(SAFE_CAST(V01.belos_adresse_empfaenger_id AS BIGNUMERIC), 0)
     END AND V05.nb_id = 0
 LEFT JOIN kfl_production_dbp_view.v_belos_adresse_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.belos_adresse_absender_num_id
    = V02.belos_adresse_num_id
 LEFT JOIN kfl_production_dbp_view.v_belos_adresse_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.belos_adresse_empfaenger_id
    = V03.belos_adresse_id
 LEFT JOIN kfl_production_dbp_view.v_belos_adresse_1 AS V04 ON V05.mandant_id = V04.mandant_id AND V05.aktuell_wup_id =
   V04.belos_adresse_num_id
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   MIN(COALESCE(dat_tms_wanko, DATE '9999-12-31')) AS dat_wanko_von
  FROM kfl_production_dbp_msi_data.ts_lagernummer_sortierung_scm_1
  GROUP BY mandant_id,
   wup_id) AS dw ON V01.belos_adresse_absender_num_id = dw.wup_id AND V01.mandant_id = dw.mandant_id
WHERE V01.belosart_fg = 1
 AND (V01.belos_adresse_absender_num_id NOT IN (6922) OR V01.dat_leistung < DATE '2025-02-17')
 AND (V01.belos_adresse_absender_num_id NOT IN (6921) OR V01.dat_leistung < DATE '2025-03-10')
 AND V01.dat_leistung < COALESCE(dw.dat_wanko_von, DATE '9999-12-31')
UNION DISTINCT
SELECT DISTINCT TMS_TOUR.mandant_id,
 - 1000 AS belos_vorgang_id,
 0 AS komplettlieferung_fg,
 0 AS loesch_fg,
 0 AS in_time_fg,
 0 AS av_fg,
 1 AS distribution_abr_fg,
 0 AS sammel_ladung_fg,
 0 AS nb_id,
 '' AS sendung_gew_einh_id,
 '' AS sendung_vol_einh_id,
 DATE '1900-01-01' AS dat_lief_soll,
 DATE '1900-01-01' AS dat_zustellung,
 0 AS sendung_id,
 0 AS wup_id,
 '' AS lagerort_id,
 0 AS hgp_id,
 0 AS gewicht_sendung,
 '' AS zustellart_id,
 '' AS belos_vorgangart_id,
 '' AS transportauftrag_id,
 '' AS sonderabwicklung_id,
 ROUND(SAFE_CAST(TMS_TOUR.startlager_tms_gp_id AS BIGNUMERIC), 0) AS belos_adresse_absender_num_id,
 '' AS belos_adresse_abholung_id,
 '' AS belos_adresse_empfaenger_id,
 0 AS belos_adresse_empf_num_id,
 '' AS belos_adresse_spedition_id,
 0 AS vol_stauraum,
 0 AS debitor_id,
 0 AS anz_unterverpackung,
 '' AS unterverpackung_menge_einh_id,
 ROUND(SAFE_CAST(RIGHT(TMS_TOUR.transportation_unit_id_ext, LENGTH(TRIM(TMS_TOUR.transportation_unit_id_ext)) - 6) AS
   BIGNUMERIC), 0) AS tour_id,
 ROUND(CAST(CASE
    WHEN TMS_TOUR.tms_tourart_detail_id IN (4, 5)
    THEN SUBSTR(CAST(TMS_TOUR.tms_tour_id AS STRING), 1, 20)
    ELSE RIGHT(TMS_TOUR.transportation_unit_id_ext, LENGTH(TRIM(TMS_TOUR.transportation_unit_id_ext)) - 6)
    END AS BIGNUMERIC), 0) AS tour_id_auftrag,
 0 AS leergut_abh_fg,
 0 AS retouren_fg,
 0 AS industrie_abh_fg,
 '' AS lagernummer_id,
 0 AS anz_stellplatz_sap,
 0 AS anz_kolli,
 0 AS anz_stellplatz,
 TMS_TOUR.mandant_id AS mandant_id_debitor
FROM kfl_production_dbp_view.v_tms_tour_1 AS TMS_TOUR_1
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   MIN(dat_tms_wanko) AS dat_tms_wanko
  FROM kfl_production_dbp_msi_v_view.v_ts_lagernummer_sortierung_scm_1
  WHERE dat_tms_wanko IS NOT NULL
  GROUP BY mandant_id,
   wup_id) AS dw ON TMS_TOUR.mandant_id = dw.mandant_id AND dw.wup_id = ROUND(SAFE_CAST(TMS_TOUR.startlager_tms_gp_id AS
     BIGNUMERIC), 0)
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   MIN(dat) AS dat
  FROM kfl_production_dbp_msi_data.ts_lagerort_ewm_dat_1
  GROUP BY mandant_id,
   wup_id) AS ewm ON TMS_TOUR.mandant_id = ewm.mandant_id AND ewm.wup_id = ROUND(SAFE_CAST(TMS_TOUR.startlager_tms_gp_id
     AS BIGNUMERIC), 0)
WHERE TMS_TOUR.dat_tour >= COALESCE(dw.dat_tms_wanko, DATE '9999-12-31')
 AND TMS_TOUR.dat_tour < COALESCE(ewm.dat, DATE '9999-12-31');