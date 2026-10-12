CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_frontend_id30_wb_1 AS SELECT JF.mandant_id,
 JF.calendar_year AS year_id,
 JF.calendar_week AS week_id,
  JF.calendar_year || TRIM(CAST(ROUND(CAST(JF.calendar_week AS BIGNUMERIC), 0) AS STRING FORMAT '00')) AS kjwo,
 JF.aktion_id,
 JF.aktion_dat_von,
 JF.art_id AS sku_id,
 TD_ART.kl_art_id,
 JF.art_name AS sku_name,
 JF.wg_bez,
 JF.wug_bez,
 JF.promo_stores,
 JF.vk_aktion_brutto,
 JF.stock_initial,
 JF.sales_promo_week,
 JF.sell_ratio_promo_week,
 JF.sales_total,
 JF.current_sell_ratio,
 JF.remaining_stock,
 COALESCE(CAST(DC.markdown_decision AS BIGNUMERIC), 0) AS markdown_decision,
 CONCAT(COALESCE(MD1.markdown_decision_id, 0), ' - ', COALESCE(MD1.markdown_decision, 'Markdown')) AS
 markdown_decision_bez,
 COALESCE(COMM.jf_comment, '') AS manual_comment,
 COALESCE(CAST(FIN.markdown_decision AS BIGNUMERIC), - 1) AS sumbitted_decision_id,
 CAST(NULL AS FLOAT64) AS purchasing_price,
 CAST(NULL AS FLOAT64) AS rohertrag,
 TD_WERBE_ART.kl_art_id AS werbemutter,
 JF.wg_id AS warengruppe_id,
 JF.model_date AS model_run_time,
 COALESCE(ART_CLUST.article_cluster_id, 0) AS article_cluster,
 returns_last_6_months.article_returns
FROM kfl_nfmd_core.src_hdp_frontend_screen_jf_1 AS JF
 INNER JOIN kfl_nfmd_core.src_teradata_master_data_art_1 AS TD_ART ON JF.art_id = TD_ART.art_id AND JF.mandant_id = TD_ART
   .mandant_id
 LEFT JOIN kfl_nfmd_core.src_teradata_master_data_art_1 AS TD_WERBE_ART ON JF.werbemutter_id = TD_WERBE_ART.art_id AND JF
   .mandant_id = TD_WERBE_ART.mandant_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_id30_latest_wb_1 AS DC ON CAST(JF.calendar_year AS FLOAT64) = DC.year_id AND CAST(JF.calendar_week AS FLOAT64)
      = DC.week_id AND JF.aktion_id = DC.aktion_id AND JF.art_id = DC.sku_id AND JF.mandant_id = DC.mandant_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_id30_latest_comm_wb_1 AS COMM ON CAST(JF.calendar_year AS FLOAT64) = COMM.year_id AND CAST(JF.calendar_week AS FLOAT64)
      = COMM.week_id AND JF.aktion_id = COMM.aktion_id AND JF.art_id = COMM.sku_id AND JF.mandant_id = COMM.mandant_id
 LEFT JOIN kfl_nfmd_core.ts_id30_msi_final_submit_1 AS FIN ON CAST(JF.calendar_year AS FLOAT64) = FIN.year_id AND CAST(JF.calendar_week AS FLOAT64)
      = FIN.week_id AND JF.aktion_id = FIN.aktion_id AND JF.art_id = FIN.sku_id AND JF.mandant_id = FIN.mandant_id
 LEFT JOIN (SELECT mandant_id,
   sku_id,
   COUNT(1) AS article_returns
  FROM kfl_nfmd_core.ts_id30_msi_final_submit_1
  WHERE CAST(markdown_decision AS INTEGER) IN (1, 2, 3, 4, 5)
   AND CAST(year_id AS STRING) || TRIM(CAST(CAST(week_id AS BIGNUMERIC) AS STRING FORMAT '00')) >= FORMAT_TIMESTAMP('%Y%m'
     , CAST(DATETIME_ADD(CAST(CURRENT_TIMESTAMP() AS DATETIME), INTERVAL - 6 MONTH) AS TIMESTAMP))
  GROUP BY mandant_id,
   sku_id) AS returns_last_6_months ON JF.mandant_id = returns_last_6_months.mandant_id AND JF.art_id =
   returns_last_6_months.sku_id
 LEFT JOIN kfl_nfmd_core.ts_l_markdown_decision_1 AS MD1 ON CAST(DC.markdown_decision AS FLOAT64) = MD1.markdown_decision_id
    AND DC.mandant_id = MD1.mandant_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_latest_artice_cluster_wb_1 AS ART_CLUST ON CAST(JF.calendar_year AS FLOAT64) =
      ART_CLUST.year_id AND CAST(JF.calendar_week AS FLOAT64) = ART_CLUST.week_id AND JF.aktion_id = ART_CLUST.aktion_id
      AND JF.art_id = CAST(ART_CLUST.sku_id AS FLOAT64) AND JF.mandant_id = ART_CLUST.mandant_id;