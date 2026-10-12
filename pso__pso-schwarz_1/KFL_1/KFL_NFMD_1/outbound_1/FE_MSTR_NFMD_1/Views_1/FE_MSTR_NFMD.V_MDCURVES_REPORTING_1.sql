CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.v_mdcurves_reporting_1 AS SELECT CTR.ctrl_v_treatment,
 COALESCE(MD2.markdown_decision, 'None') AS submitted_decesion,
 CURV.art_id,
 CURV.wup_id,
 CURV.kl_art_bez AS sku_name,
 CURV.wup_name_e AS wup_name,
 CURV.wup_cluster_id AS wup_cluster,
 CURV.wup_region,
 RI.vs_bez AS region_1,
 CURV.curve_week,
 FS.submitted_price,
  CASE
  WHEN FS.created_at <= (SELECT MAX(timestamp)
    FROM kfl_nfmd_core.sap_pipeline_writeback_1)
  THEN FS.submitted_price
  ELSE NULL
  END AS submitted_and_loaded_price,
 FS.valid_from_date,
 ROUND(FS.submitted_price / CURV.vk_aktion_brutto, 4) AS discount,
 PS.nb_of_markdowns,
  CASE
  WHEN FS.src_md_price_opt <> FS.submitted_price
  THEN 'Overwritten'
  WHEN FS.src_md_price_opt = FS.submitted_price
  THEN 'Model recommendation'
  ELSE NULL
  END AS overwritten,
 CURV.aktion_id,
 CURV.aktion_dat_von,
 CURV.calendar_year,
 CURV.calendar_week,
 CURV.promo_week,
 CURV.vk_aktion_brutto,
 CURV.currency,
 CURV.hwg_bez,
 CURV.owg_bez,
 CURV.wg_bez,
 CURV.wug_bez,
 CURV.stock_initial,
 CURV.sales_1,
 CURV.cumulated_sales,
 CURV.revenue,
 CURV.sell_ratio,
 CURV.price_ratio,
 CURV.werbemutter_id,
 CURV.mandant_id,
 CURV.model_date,
 DATE(SUBSTR(CURV.model_date, 1, 8)) AS model_date_format,
 CURV.model_id
FROM kfl_nfmd_core.src_hdp_md_curves_master_reporting_1 AS CURV
 INNER JOIN kfl_nfmd_core.control_vs_treatment_csv_1 AS CTR ON CURV.wup_id = CTR.wup_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_product_statistics_1 AS PS ON CAST(CURV.calendar_year AS FLOAT64) = PS.year_id AND CAST(CURV.calendar_week AS FLOAT64)
      = PS.week_id AND CURV.mandant_id = PS.mandant_id AND CURV.art_id = PS.sku_id AND CURV.wup_id = PS.wup_id
 LEFT JOIN kfl_nfmd_core.ts_id30_msi_final_submit_1 AS ID30 ON CAST(CURV.calendar_year AS FLOAT64) = ID30.year_id AND CAST(CURV.calendar_week AS FLOAT64)
      = ID30.week_id AND CURV.mandant_id = ID30.mandant_id AND CURV.aktion_id = ID30.aktion_id AND CURV.art_id = ID30.sku_id
   
 LEFT JOIN kfl_nfmd_core.ts_l_markdown_decision_1 AS MD2 ON CAST(ID30.markdown_decision AS FLOAT64) = MD2.markdown_decision_id
  
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_lookup_dates_1 AS LD ON CAST(CURV.calendar_week AS FLOAT64) = LD.week_iso AND CAST(CURV.calendar_year AS FLOAT64)
   = LD.year_iso
 LEFT JOIN kfl_nfmd_core.ts_id40_final_submit_1 AS FS ON CAST(CURV.calendar_week AS FLOAT64) = FS.week_id AND CAST(CURV.calendar_year AS FLOAT64)
        = FS.year_id AND CURV.mandant_id = FS.mandant_id AND CURV.aktion_id = FS.aktion_id AND CURV.art_id = FS.sku_id
   AND CURV.wup_id = FS.wup_id AND CASE
    WHEN DATETIME_DIFF(FS.valid_from_date, CAST(LD.thursday_of_week AS DATETIME), DAY) < 7
    THEN 1
    WHEN DATETIME_DIFF(FS.valid_from_date, CAST(LD.thursday_of_week AS DATETIME), DAY) >= 7 AND DATETIME_DIFF(FS.valid_from_date
       ,CAST(LD.thursday_of_week AS DATETIME), DAY) < 14
    THEN 2
    WHEN DATETIME_DIFF(FS.valid_from_date, CAST(LD.thursday_of_week AS DATETIME), DAY) >= 14 AND DATETIME_DIFF(FS.valid_from_date
       ,CAST(LD.thursday_of_week AS DATETIME), DAY) < 21
    THEN 3
    WHEN DATETIME_DIFF(FS.valid_from_date, CAST(LD.thursday_of_week AS DATETIME), DAY) >= 21 AND DATETIME_DIFF(FS.valid_from_date
       ,CAST(LD.thursday_of_week AS DATETIME), DAY) < 28
    THEN 4
    WHEN DATETIME_DIFF(FS.valid_from_date, CAST(LD.thursday_of_week AS DATETIME), DAY) >= 28 AND DATETIME_DIFF(FS.valid_from_date
       ,CAST(LD.thursday_of_week AS DATETIME), DAY) < 35
    THEN 5
    WHEN DATETIME_DIFF(FS.valid_from_date, CAST(LD.thursday_of_week AS DATETIME), DAY) >= 35 AND DATETIME_DIFF(FS.valid_from_date
       ,CAST(LD.thursday_of_week AS DATETIME), DAY) < 42
    THEN 6
    WHEN DATETIME_DIFF(FS.valid_from_date, CAST(LD.thursday_of_week AS DATETIME), DAY) >= 42 AND DATETIME_DIFF(FS.valid_from_date
       ,CAST(LD.thursday_of_week AS DATETIME), DAY) < 49
    THEN 7
    WHEN DATETIME_DIFF(FS.valid_from_date, CAST(LD.thursday_of_week AS DATETIME), DAY) >= 49 AND DATETIME_DIFF(FS.valid_from_date
       ,CAST(LD.thursday_of_week AS DATETIME), DAY) < 56
    THEN 8
    ELSE NULL
    END = CURV.curve_week
 LEFT JOIN kfl_nfmd_core.src_teradata_master_data_wup_1 AS MDW ON CURV.wup_id = MDW.wup_id AND CURV.mandant_id = MDW.mandant_id
   
 LEFT JOIN kfl_nfmd_core.l_region_ids_1 AS RI ON MDW.vs_id = RI.vs_id AND MDW.mandant_id = RI.mandant_id
WHERE CURV.promo_week >= 202129
 AND MD2.markdown_decision_id = 0;