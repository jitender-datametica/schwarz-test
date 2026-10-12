CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_aad_scenario_hit_2 AS WITH THRESHOLDS AS (SELECT scenario_id,
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
   vs_id), T_ANTRAG_BEDIENER AS (SELECT mandant_id,
   hashed_cashier_id,
   MAX(request_status_type_id) AS max_status_pro_bediener
  FROM kfl_production_dbp_msi_data.ts_aad_request_workflow_2
  WHERE CAST(expiration_tmsp AS DATE) > CURRENT_DATE
  GROUP BY mandant_id,
   hashed_cashier_id) (SELECT DISTINCT v01.scenario_id,
   v01.bon_id,
   v01.bon_dat,
   V03.aktuell_wup_id AS wup_id,
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
  FROM (SELECT DISTINCT HITS.scenario_id,
     HITS.bon_id,
     HITS.bon_dat,
     HITS.wup_id,
     HITS.mandant_id,
     HITS.wrg_id,
     HITS.bon_nr,
     HITS.bon_booking,
     HITS.kasse_nr,
     HITS.hashed_cashier_id,
     HITS.fraud_value_gross_local_val,
     HITS.dwh_created_tmsp,
     HITS.dwh_updated_tmsp,
     COUNT(*) OVER (PARTITION BY HITS.scenario_id, HITS.mandant_id, HITS.wup_id, HITS.hashed_cashier_id, tmp.bon_dat
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_hits_in_timeframe,
     tmp.cnt_hits
    FROM kfl_production_dbp_view.v_aad_scenario_hit_2 AS HITS
     INNER JOIN (SELECT t6.scenario_id,
       t6.bon_dat,
       t6.wup_id,
       t6.mandant_id,
       t6.hashed_cashier_id,
       t6.timeframe,
       t6.cnt_hits,
       DATE_ADD(t6.bon_dat, INTERVAL CAST(- t6.timeframe AS INTEGER) DAY) AS date_from
      FROM (SELECT SH.scenario_id,
         SH.mandant_id,
         SH.wup_id,
         SH.hashed_cashier_id,
         SH.bon_dat,
         COALESCE(thr_reg.timeframe, thr_cntr.timeframe) AS timeframe,
         COALESCE(thr_reg.cnt_hits, thr_cntr.cnt_hits) AS cnt_hits
        FROM kfl_production_dbp_view.v_aad_scenario_hit_2 AS SH
         INNER JOIN kfl_production_dbp_view.v_wup_2 AS W ON SH.mandant_id = W.mandant_id AND SH.wup_id = W.wup_id
         INNER JOIN THRESHOLDS AS thr_cntr ON SH.scenario_id = thr_cntr.scenario_id AND SH.mandant_id = thr_cntr.mandant_id
             AND thr_cntr.vs_id = 0
         LEFT JOIN THRESHOLDS AS thr_reg ON SH.scenario_id = thr_reg.scenario_id AND SH.mandant_id = thr_reg.mandant_id
          AND W.vs_id = thr_reg.vs_id
        GROUP BY SH.scenario_id,
         SH.mandant_id,
         SH.wup_id,
         SH.hashed_cashier_id,
         SH.bon_dat,
         timeframe,
         cnt_hits) AS t6) AS tmp ON HITS.scenario_id = tmp.scenario_id AND HITS.mandant_id = tmp.mandant_id AND HITS.wup_id
          = tmp.wup_id AND HITS.hashed_cashier_id = tmp.hashed_cashier_id AND HITS.bon_dat BETWEEN tmp.date_from AND tmp
       .bon_dat) AS v01
   LEFT JOIN T_ANTRAG_BEDIENER AS v02 ON v01.mandant_id = v02.mandant_id AND v01.hashed_cashier_id = v02.hashed_cashier_id
     
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS V03 ON v01.wup_id = V03.wup_id AND v01.mandant_id = V03.mandant_id
  WHERE v01.cnt_hits_in_timeframe >= v01.cnt_hits);