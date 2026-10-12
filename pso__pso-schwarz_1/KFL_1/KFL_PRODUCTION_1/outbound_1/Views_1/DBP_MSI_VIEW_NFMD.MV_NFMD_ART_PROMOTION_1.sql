CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_nfmd_art_promotion_1 AS WITH RETURN_LAST6MONTHS AS (SELECT
   APPROVE.mandant_id,
   APPROVE.art_id,
   COUNT(1) AS article_returns
  FROM kfl_production_dbp_msi_view_nfmd.ts_nfmd_approved_decision_1 AS APPROVE
   INNER JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 AS DECISION ON APPROVE.mandant_id = DECISION.mandant_id
       AND APPROVE.markdown_decision_id = DECISION.markdown_decision_id AND DECISION.retoure_fg = 1
  WHERE APPROVE.kjwo_ww >= CAST(FORMAT_DATE('%Y%m', DATE_ADD(CURRENT_DATE, INTERVAL - 6 MONTH)) AS FLOAT64)
  GROUP BY APPROVE.mandant_id,
   APPROVE.art_id) (SELECT JF.mandant_id,
   JF.kjwo_ww,
   JF.promo_start_dt,
   JF.art_id,
   JF.promo_stores_cnt,
   JF.selling_price_gross_local_val,
   JF.stock_initial_cnt,
   JF.sales_promo_week_cnt,
   JF.promo_week_sell_rate,
   JF.sell_ratio_wk12,
   JF.sell_ratio_wk123,
   JF.sales_total_cnt,
   JF.current_sell_rate,
   JF.remaining_stock_cnt,
   COALESCE(COALESCE(DC.markdown_decision_id, FIN.markdown_decision_id), - 1) AS markdown_decision,
   CONCAT(COALESCE(MD1.markdown_decision_id, 0), ' - ', COALESCE(MD1.markdown_decision_descr, 'Markdown')) AS
   markdown_decision_bez,
   COALESCE(COMM.comment_txt, '') AS manual_comment,
   COALESCE(FIN.markdown_decision_id, - 1) AS sumbitted_decision_id,
   CAST(NULL AS FLOAT64) AS purchasing_price,
   CAST(NULL AS FLOAT64) AS rohertrag,
   JF.wg_id,
   JF.wrg_id,
   JF.model_execution_tmsp,
   COALESCE(ART_CLUST.article_cluster_id, 0) AS article_cluster,
   t3.article_returns,
   JF.next_promo_start_dt,
   JF.display_art_id,
    JF.selling_price_gross_local_val / (1 + MWST_PER.mwst / 100) AS vk_netto,
    CASE
    WHEN JF.next_promo_start_dt IS NOT NULL AND COALESCE(COALESCE(DC.markdown_decision_id, FIN.markdown_decision_id), -
        1) = 0 AND COALESCE(FIN.markdown_decision_id, - 1) <> 0
    THEN 1
    ELSE 0
    END AS next_promo_markdown_fg
  FROM kfl_production_dbp_view.v_nfmd_art_promotion_1 AS JF
   INNER JOIN kfl_production_dbp_view.v_art_1 AS ART_1 ON JF.art_id = ART.art_id AND JF.mandant_id = ART.mandant_id
   INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS MWST_PER_1 ON ART.mwst_id = MWST_PER.mwst_id AND ART.mandant_id =
      MWST_PER.mandant_id AND MWST_PER.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_proposed_decision_1 AS DC ON JF.kjwo_ww = DC.kjwo_ww AND JF.art_id
       = DC.art_id AND JF.mandant_id = DC.mandant_id
   LEFT JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_comments_1 AS COMM ON JF.kjwo_ww = COMM.kjwo_ww AND JF.art_id = COMM
      .art_id AND JF.mandant_id = COMM.mandant_id
   LEFT JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_approved_decision_1 AS FIN ON JF.kjwo_ww = FIN.kjwo_ww AND JF.art_id
       = FIN.art_id AND JF.mandant_id = FIN.mandant_id
   LEFT JOIN RETURN_LAST6MONTHS AS t3 ON JF.mandant_id = t3.mandant_id AND JF.art_id = t3.art_id
   LEFT JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 AS MD1 ON DC.markdown_decision_id = MD1.markdown_decision_id
      AND DC.mandant_id = MD1.mandant_id
   LEFT JOIN kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_article_article_cluster_rel_1 AS ART_CLUST ON JF.kjwo_ww =
      ART_CLUST.kjwo_ww AND JF.art_id = ART_CLUST.art_id AND JF.mandant_id = ART_CLUST.mandant_id);