CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_lagerbestand_erp_per AS WITH RELEVANTE_ART AS (SELECT
  DISTINCT art_id,
   display_art_id,
   mandant_id
  FROM kfl_production_dbp_data.nfmd_art_promotion), STEUCKLISTE AS (SELECT V0.mandant_id,
   V0.art_id AS display_art_id,
   V1.art_id,
   V1.komponentenmenge
  FROM kfl_production_dbp_view.v_stueckliste AS V0
   INNER JOIN kfl_production_dbp_view.v_stueckliste_det AS V1 ON V0.mandant_id = V1.mandant_id AND V0.stueckliste_id =
     V1.stueckliste_id
  WHERE V1.dat_bis > CURRENT_DATE) (SELECT v00.art_id,
   v00.mandant_id,
   v00.display_art_id,
   v02.komponentenmenge,
   SUM(V01.menge_lgbest_erp_frei_bme) AS menge_lgbest_erp_frei_bme,
   SUM(V01.menge_lgbest_erp_gesp_bme + V01.menge_lgbest_erp_qual_bme + V01.menge_lgbest_erp_ret_gesp_bme) AS
   menge_lgbest_erp_gesperrt_bme,
    COALESCE(SUM(V01.menge_lgbest_erp_frei_bme), 0) / v02.komponentenmenge AS menge_lgbest_display_komponenten,
   MIN(COALESCE(SUM(V01.menge_lgbest_erp_frei_bme), 0) / v02.komponentenmenge) OVER (PARTITION BY CAST(v00.mandant_id AS STRING)
      , CAST(v00.display_art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
   menge_lgbest_min_display_komponente
  FROM RELEVANTE_ART AS v00
   LEFT JOIN kfl_production_dbp_view.v_lagerbestand_erp_per AS V01 ON v00.mandant_id = V01.mandant_id AND v00.art_id =
      V01.art_id AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN V01.dat_von AND V01.dat_bis
   LEFT JOIN STEUCKLISTE AS v02 ON v00.mandant_id = v02.mandant_id AND v00.art_id = v02.art_id AND v00.display_art_id =
     v02.display_art_id
  GROUP BY v00.art_id,
   v00.mandant_id,
   v02.komponentenmenge,
   v00.display_art_id);