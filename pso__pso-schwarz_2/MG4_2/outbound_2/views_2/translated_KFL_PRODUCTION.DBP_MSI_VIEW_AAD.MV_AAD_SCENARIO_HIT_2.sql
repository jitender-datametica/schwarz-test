CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_aad_scenario_hit_2 AS WITH thresholds AS (SELECT scenario_id,
   mandant_id,
   region_id AS vs_id,
   MAX(CASE
     WHEN scenario_metric_id = 98
     THEN scenario_metric_threshold_init_val
     ELSE NULL
     END) AS timeframe,
   MAX(CASE
     WHEN scenario_metric_id = 99
     THEN scenario_metric_threshold_init_val
     ELSE NULL
     END) AS cnt_hits
  FROM kfl_production_dbp_view.v_aad_scenario_metric_threshold_2
  GROUP BY scenario_id,
   mandant_id,
   vs_id), t_antrag_bediener AS (SELECT mandant_id,
   hashed_cashier_id,
   MAX(request_status_type_id) AS max_status_pro_bediener
  FROM kfl_production_dbp_msi_data.ts_aad_request_workflow_2
  WHERE CAST(expiration_tmsp AS DATE) > CURRENT_DATE
  GROUP BY mandant_id,
   hashed_cashier_id) (SELECT DISTINCT v01.scenario_id,
   v01.bon_id,
   v01.bon_dat,
   v03.aktuell_wup_id AS wup_id,
   v01.mandant_id,
   v01.wrg_id,
   v01.bon_nr,
   v01.bon_booking,
   v01.kasse_nr,
   v01.hashed_cashier_id,
   v01.fraud_value_gross_local_val,
   v01.dwh_created_tmsp,
   v01.dwh_updated_tmsp,
   1 AS cnt_zeile_hit,
   COALESCE(v02.max_status_pro_bediener, 0) AS aktueller_status_hit
  FROM (SELECT DISTINCT hits.scenario_id,
     hits.bon_id,
     hits.bon_dat,
     hits.wup_id,
     hits.mandant_id,
     hits.wrg_id,
     hits.bon_nr,
     hits.bon_booking,
     hits.kasse_nr,
     hits.hashed_cashier_id,
     hits.fraud_value_gross_local_val,
     hits.dwh_created_tmsp,
     hits.dwh_updated_tmsp,
     COUNT(*) OVER (PARTITION BY hits.scenario_id, hits.mandant_id, hits.wup_id, hits.hashed_cashier_id, tmp.bon_dat
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_hits_in_timeframe,
     tmp.cnt_hits
    FROM kfl_production_dbp_view.v_aad_scenario_hit_2 AS hits
     INNER JOIN (SELECT t6.scenario_id,
       t6.bon_dat,
       t6.wup_id,
       t6.mandant_id,
       t6.hashed_cashier_id,
       t6.timeframe,
       t6.cnt_hits,
       DATE_ADD(t6.bon_dat, INTERVAL CAST(- t6.timeframe AS INTEGER) DAY) AS date_from
      FROM (SELECT sh.scenario_id,
         sh.mandant_id,
         sh.wup_id,
         sh.hashed_cashier_id,
         sh.bon_dat,
         COALESCE(thr_reg.timeframe, thr_cntr.timeframe) AS timeframe,
         COALESCE(thr_reg.cnt_hits, thr_cntr.cnt_hits) AS cnt_hits
        FROM kfl_production_dbp_view.v_aad_scenario_hit_2 AS sh
         INNER JOIN kfl_production_dbp_view.v_wup_2 AS w ON sh.mandant_id = w.mandant_id AND sh.wup_id = w.wup_id
         INNER JOIN thresholds AS thr_cntr ON sh.scenario_id = thr_cntr.scenario_id AND sh.mandant_id = thr_cntr.mandant_id
             AND thr_cntr.vs_id = 0
         LEFT JOIN thresholds AS thr_reg ON sh.scenario_id = thr_reg.scenario_id AND sh.mandant_id = thr_reg.mandant_id
          AND w.vs_id = thr_reg.vs_id
        GROUP BY sh.scenario_id,
         sh.mandant_id,
         sh.wup_id,
         sh.hashed_cashier_id,
         sh.bon_dat,
         timeframe,
         cnt_hits) AS t6) AS tmp ON hits.scenario_id = tmp.scenario_id AND hits.mandant_id = tmp.mandant_id AND hits.wup_id
          = tmp.wup_id AND hits.hashed_cashier_id = tmp.hashed_cashier_id AND hits.bon_dat BETWEEN tmp.date_from AND tmp
       .bon_dat) AS v01
   LEFT JOIN t_antrag_bediener AS v02 ON v01.mandant_id = v02.mandant_id AND v01.hashed_cashier_id = v02.hashed_cashier_id
     
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS v03 ON v01.wup_id = v03.wup_id AND v01.mandant_id = v03.mandant_id
  WHERE v01.cnt_hits_in_timeframe >= v01.cnt_hits);