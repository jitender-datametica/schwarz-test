CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_nfmd_article_store_scorecard_2 (mandant_id, kjwo_ww, aktion_id
, promo_start_dt, selling_price_gross_local_val, wrg_id, promo_stores_cnt, wup_id, art_id, discount_type_name,
second_discount_start_dt, second_discount_end_dt, wg_id, stock_initial_cnt, sales_promo_week_cnt, promo_week_sell_rate,
sell_ratio_wk12, sell_ratio_wk123, sales_total_cnt, current_sell_rate, remaining_stock_cnt, current_discount_rate,
current_week_nr, remaining_weeks_cnt, revenue_last_week_gross_local_val, total_revenue_gross_local_val,
src_model_price_gross_local_val, model_execution_tmsp, art_warenwert, sap_transfer_date, submitted_date,
helper_last_manual, last_manual_price, previous_submitted_valid_from, last_manual_updated_date, last_manual_valid_from,
valid_from, nb_of_markdowns, helper_md_price, helper_manual_price, md_discount_opt, md_price_opt,
manual_markdown_percentage, manual_markdown_price, manual_comment, id40_submitted_price, purchasing_price, rohertrag,
previous_submitted_price, article_cluster_id, curve_type_cd, rule_created_dt, is_in_experiment_fg, experiment_group_cd,
experiment_stores_cnt, display_art_id, rule_decision_record, vk_netto, umsatz_netto, manual_markdown_price_netto,
checkbox_zr_default) AS SELECT SC.mandant_id,
 SC.kjwo_ww,
 SC.aktion_id,
 SC.promo_start_dt,
 SC.selling_price_gross_local_val,
 SC.wrg_id,
 SC.promo_stores_cnt,
 SC.wup_id,
 SC.art_id,
 SC.discount_type_name,
 SC.second_discount_start_dt,
 SC.second_discount_end_dt,
 SC.wg_id,
 SC.stock_initial_cnt,
 SC.sales_promo_week_cnt,
 SC.promo_week_sell_rate,
 SC.sell_ratio_wk12,
 SC.sell_ratio_wk123,
 SC.sales_total_cnt,
 SC.current_sell_rate,
 SC.remaining_stock_cnt,
 SC.current_discount_rate,
 SC.current_week_nr,
 SC.remaining_weeks_cnt,
 SC.revenue_last_week_gross_local_val,
 SC.total_revenue_gross_local_val,
 SC.model_price_gross_local_val AS src_model_price_gross_local_val,
 SC.model_execution_tmsp,
  SC.selling_price_gross_local_val * SC.remaining_stock_cnt AS art_warenwert,
 VPS.last_sap_transfer_date AS sap_transfer_date,
 VPS.submitted_date,
  CASE
  WHEN SC.discount_type_name = 'second_discount'
  THEN 'ART_WUP_LEVEL'
  WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
  THEN 'ART_LEVEL'
  WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
  THEN 'ART_WUP_LEVEL'
  ELSE NULL
  END AS helper_last_manual,
  CASE
  WHEN CASE
    WHEN SC.discount_type_name = 'second_discount'
    THEN 'ART_WUP_LEVEL'
    WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
    THEN 'ART_LEVEL'
    WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
    THEN 'ART_WUP_LEVEL'
    ELSE NULL
    END = 'ART_LEVEL'
  THEN DCA.manual_price_art
  WHEN CASE
    WHEN SC.discount_type_name = 'second_discount'
    THEN 'ART_WUP_LEVEL'
    WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
    THEN 'ART_LEVEL'
    WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
    THEN 'ART_WUP_LEVEL'
    ELSE NULL
    END = 'ART_WUP_LEVEL'
  THEN DPC.manual_price_art_wup
  ELSE NULL
  END AS last_manual_price,
  CASE
  WHEN ROUND(VPS.previous_submitted_price, 2) <> ROUND(SC.selling_price_gross_local_val, 2)
  THEN VPS.previous_submitted_valid_from
  ELSE NULL
  END AS previous_submitted_valid_from,
  CASE
  WHEN CASE
    WHEN SC.discount_type_name = 'second_discount'
    THEN 'ART_WUP_LEVEL'
    WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
    THEN 'ART_LEVEL'
    WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
    THEN 'ART_WUP_LEVEL'
    ELSE NULL
    END = 'ART_LEVEL'
  THEN DCA.updated_date
  WHEN CASE
    WHEN SC.discount_type_name = 'second_discount'
    THEN 'ART_WUP_LEVEL'
    WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
    THEN 'ART_LEVEL'
    WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
    THEN 'ART_WUP_LEVEL'
    ELSE NULL
    END = 'ART_WUP_LEVEL'
  THEN DPC.updated_date
  ELSE NULL
  END AS last_manual_updated_date,
  CASE
  WHEN DDC.updated_date IS NULL OR DCVF.updated_date > DDC.updated_date
  THEN DCVF.manual_price_art_dat
  WHEN DCVF.updated_date IS NULL OR DCVF.updated_date < DDC.updated_date
  THEN SUBSTR(CAST(DDC.manual_price_art_wup_dat AS STRING), 1, 255)
  ELSE NULL
  END AS last_manual_valid_from,
 COALESCE(CASE
   WHEN CAST(CASE
      WHEN DDC.updated_date IS NULL OR DCVF.updated_date > DDC.updated_date
      THEN DCVF.manual_price_art_dat
      WHEN DCVF.updated_date IS NULL OR DCVF.updated_date < DDC.updated_date
      THEN SUBSTR(CAST(DDC.manual_price_art_wup_dat AS STRING), 1, 255)
      ELSE NULL
      END AS DATE) > CURRENT_DATE
   THEN CASE
    WHEN DDC.updated_date IS NULL OR DCVF.updated_date > DDC.updated_date
    THEN DCVF.manual_price_art_dat
    WHEN DCVF.updated_date IS NULL OR DCVF.updated_date < DDC.updated_date
    THEN SUBSTR(CAST(DDC.manual_price_art_wup_dat AS STRING), 1, 255)
    ELSE NULL
    END
   ELSE NULL
   END, SUBSTR(CAST(UDF_SCHEMA.NEXT_DAY_BQ(CURRENT_DATE, PRMS.discount_day_of_week) AS STRING), 1, 20)) AS valid_from,
 COALESCE(VPS.nb_of_markdowns, 0) AS nb_of_markdowns,
  CASE
  WHEN SC.model_price_gross_local_val IS NULL
  THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
  ELSE SC.model_price_gross_local_val
  END AS helper_md_price,
  CASE
  WHEN (SC.selling_price_gross_local_val * SC.remaining_stock_cnt <= PRMS.min_price_gross_local_val OR SC.remaining_stock_cnt
       = 0) AND SC.mandant_id <> 5
  THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
  WHEN CASE
    WHEN CASE
      WHEN SC.discount_type_name = 'second_discount'
      THEN 'ART_WUP_LEVEL'
      WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
      THEN 'ART_LEVEL'
      WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
      THEN 'ART_WUP_LEVEL'
      ELSE NULL
      END = 'ART_LEVEL'
    THEN DCA.manual_price_art
    WHEN CASE
      WHEN SC.discount_type_name = 'second_discount'
      THEN 'ART_WUP_LEVEL'
      WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
      THEN 'ART_LEVEL'
      WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
      THEN 'ART_WUP_LEVEL'
      ELSE NULL
      END = 'ART_WUP_LEVEL'
    THEN DPC.manual_price_art_wup
    ELSE NULL
    END IS NOT NULL AND CASE
     WHEN CASE
       WHEN SC.discount_type_name = 'second_discount'
       THEN 'ART_WUP_LEVEL'
       WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
       THEN 'ART_LEVEL'
       WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
       THEN 'ART_WUP_LEVEL'
       ELSE NULL
       END = 'ART_LEVEL'
     THEN DCA.manual_price_art
     WHEN CASE
       WHEN SC.discount_type_name = 'second_discount'
       THEN 'ART_WUP_LEVEL'
       WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
       THEN 'ART_LEVEL'
       WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
       THEN 'ART_WUP_LEVEL'
       ELSE NULL
       END = 'ART_WUP_LEVEL'
     THEN DPC.manual_price_art_wup
     ELSE NULL
     END <= COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
  THEN CASE
   WHEN CASE
     WHEN SC.discount_type_name = 'second_discount'
     THEN 'ART_WUP_LEVEL'
     WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
     THEN 'ART_LEVEL'
     WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
     THEN 'ART_WUP_LEVEL'
     ELSE NULL
     END = 'ART_LEVEL'
   THEN DCA.manual_price_art
   WHEN CASE
     WHEN SC.discount_type_name = 'second_discount'
     THEN 'ART_WUP_LEVEL'
     WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
     THEN 'ART_LEVEL'
     WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
     THEN 'ART_WUP_LEVEL'
     ELSE NULL
     END = 'ART_WUP_LEVEL'
   THEN DPC.manual_price_art_wup
   ELSE NULL
   END
  ELSE CASE
   WHEN SC.model_price_gross_local_val IS NULL
   THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
   ELSE SC.model_price_gross_local_val
   END
  END AS helper_manual_price,
  CASE
  WHEN SC.selling_price_gross_local_val > 0
  THEN 1 - CASE
     WHEN SC.model_price_gross_local_val IS NULL
     THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
     ELSE SC.model_price_gross_local_val
     END / SC.selling_price_gross_local_val
  ELSE NULL
  END AS md_discount_opt,
 ROUND(CASE
   WHEN SC.model_price_gross_local_val IS NULL
   THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
   ELSE SC.model_price_gross_local_val
   END, 2) AS md_price_opt,
  CASE
  WHEN SC.selling_price_gross_local_val > 0
  THEN 1 - CASE
     WHEN (SC.selling_price_gross_local_val * SC.remaining_stock_cnt <= PRMS.min_price_gross_local_val OR SC.remaining_stock_cnt
          = 0) AND SC.mandant_id <> 5
     THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
     WHEN CASE
       WHEN CASE
         WHEN SC.discount_type_name = 'second_discount'
         THEN 'ART_WUP_LEVEL'
         WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
         THEN 'ART_LEVEL'
         WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
         THEN 'ART_WUP_LEVEL'
         ELSE NULL
         END = 'ART_LEVEL'
       THEN DCA.manual_price_art
       WHEN CASE
         WHEN SC.discount_type_name = 'second_discount'
         THEN 'ART_WUP_LEVEL'
         WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
         THEN 'ART_LEVEL'
         WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
         THEN 'ART_WUP_LEVEL'
         ELSE NULL
         END = 'ART_WUP_LEVEL'
       THEN DPC.manual_price_art_wup
       ELSE NULL
       END IS NOT NULL AND CASE
        WHEN CASE
          WHEN SC.discount_type_name = 'second_discount'
          THEN 'ART_WUP_LEVEL'
          WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
          THEN 'ART_LEVEL'
          WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
          THEN 'ART_WUP_LEVEL'
          ELSE NULL
          END = 'ART_LEVEL'
        THEN DCA.manual_price_art
        WHEN CASE
          WHEN SC.discount_type_name = 'second_discount'
          THEN 'ART_WUP_LEVEL'
          WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
          THEN 'ART_LEVEL'
          WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
          THEN 'ART_WUP_LEVEL'
          ELSE NULL
          END = 'ART_WUP_LEVEL'
        THEN DPC.manual_price_art_wup
        ELSE NULL
        END <= COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
     THEN CASE
      WHEN CASE
        WHEN SC.discount_type_name = 'second_discount'
        THEN 'ART_WUP_LEVEL'
        WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
        THEN 'ART_LEVEL'
        WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
        THEN 'ART_WUP_LEVEL'
        ELSE NULL
        END = 'ART_LEVEL'
      THEN DCA.manual_price_art
      WHEN CASE
        WHEN SC.discount_type_name = 'second_discount'
        THEN 'ART_WUP_LEVEL'
        WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
        THEN 'ART_LEVEL'
        WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
        THEN 'ART_WUP_LEVEL'
        ELSE NULL
        END = 'ART_WUP_LEVEL'
      THEN DPC.manual_price_art_wup
      ELSE NULL
      END
     ELSE CASE
      WHEN SC.model_price_gross_local_val IS NULL
      THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
      ELSE SC.model_price_gross_local_val
      END
     END / SC.selling_price_gross_local_val
  ELSE NULL
  END AS manual_markdown_percentage,
 ROUND(CASE
   WHEN (SC.selling_price_gross_local_val * SC.remaining_stock_cnt <= PRMS.min_price_gross_local_val OR SC.remaining_stock_cnt
        = 0) AND SC.mandant_id <> 5
   THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
   WHEN CASE
     WHEN CASE
       WHEN SC.discount_type_name = 'second_discount'
       THEN 'ART_WUP_LEVEL'
       WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
       THEN 'ART_LEVEL'
       WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
       THEN 'ART_WUP_LEVEL'
       ELSE NULL
       END = 'ART_LEVEL'
     THEN DCA.manual_price_art
     WHEN CASE
       WHEN SC.discount_type_name = 'second_discount'
       THEN 'ART_WUP_LEVEL'
       WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
       THEN 'ART_LEVEL'
       WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
       THEN 'ART_WUP_LEVEL'
       ELSE NULL
       END = 'ART_WUP_LEVEL'
     THEN DPC.manual_price_art_wup
     ELSE NULL
     END IS NOT NULL AND CASE
      WHEN CASE
        WHEN SC.discount_type_name = 'second_discount'
        THEN 'ART_WUP_LEVEL'
        WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
        THEN 'ART_LEVEL'
        WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
        THEN 'ART_WUP_LEVEL'
        ELSE NULL
        END = 'ART_LEVEL'
      THEN DCA.manual_price_art
      WHEN CASE
        WHEN SC.discount_type_name = 'second_discount'
        THEN 'ART_WUP_LEVEL'
        WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
        THEN 'ART_LEVEL'
        WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
        THEN 'ART_WUP_LEVEL'
        ELSE NULL
        END = 'ART_WUP_LEVEL'
      THEN DPC.manual_price_art_wup
      ELSE NULL
      END <= COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
   THEN CASE
    WHEN CASE
      WHEN SC.discount_type_name = 'second_discount'
      THEN 'ART_WUP_LEVEL'
      WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
      THEN 'ART_LEVEL'
      WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
      THEN 'ART_WUP_LEVEL'
      ELSE NULL
      END = 'ART_LEVEL'
    THEN DCA.manual_price_art
    WHEN CASE
      WHEN SC.discount_type_name = 'second_discount'
      THEN 'ART_WUP_LEVEL'
      WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
      THEN 'ART_LEVEL'
      WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
      THEN 'ART_WUP_LEVEL'
      ELSE NULL
      END = 'ART_WUP_LEVEL'
    THEN DPC.manual_price_art_wup
    ELSE NULL
    END
   ELSE CASE
    WHEN SC.model_price_gross_local_val IS NULL
    THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
    ELSE SC.model_price_gross_local_val
    END
   END, 2) AS manual_markdown_price,
 COALESCE(COMM.comment_txt, '') AS manual_comment,
 VPS.submitted_price AS id40_submitted_price,
 CAST(NULL AS FLOAT64) AS purchasing_price,
 CAST(NULL AS FLOAT64) AS rohertrag,
 VPS.previous_submitted_price,
 COALESCE(ART_CLUST.article_cluster_id, 0) AS article_cluster_id,
 COALESCE(SC.curve_type_cd, 0) AS curve_type_cd,
 SC.rule_created_dt,
 COALESCE(SC.is_in_experiment_fg, 0) AS is_in_experiment_fg,
 COALESCE(SC.experiment_group_cd, '-') AS experiment_group_cd,
 COALESCE(SC.experiment_stores_cnt, 0) AS experiment_stores_cnt,
 SC.display_art_id,
 SC.rule_decision_record,
  SC.selling_price_gross_local_val / (1 + MWST_PER.mwst / 100) AS vk_netto,
  SC.total_revenue_gross_local_val / (1 + MWST_PER.mwst / 100) AS umsatz_netto,
  ROUND(CASE
    WHEN (SC.selling_price_gross_local_val * SC.remaining_stock_cnt <= PRMS.min_price_gross_local_val OR SC.remaining_stock_cnt
         = 0) AND SC.mandant_id <> 5
    THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
    WHEN CASE
      WHEN CASE
        WHEN SC.discount_type_name = 'second_discount'
        THEN 'ART_WUP_LEVEL'
        WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
        THEN 'ART_LEVEL'
        WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
        THEN 'ART_WUP_LEVEL'
        ELSE NULL
        END = 'ART_LEVEL'
      THEN DCA.manual_price_art
      WHEN CASE
        WHEN SC.discount_type_name = 'second_discount'
        THEN 'ART_WUP_LEVEL'
        WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
        THEN 'ART_LEVEL'
        WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
        THEN 'ART_WUP_LEVEL'
        ELSE NULL
        END = 'ART_WUP_LEVEL'
      THEN DPC.manual_price_art_wup
      ELSE NULL
      END IS NOT NULL AND CASE
       WHEN CASE
         WHEN SC.discount_type_name = 'second_discount'
         THEN 'ART_WUP_LEVEL'
         WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
         THEN 'ART_LEVEL'
         WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
         THEN 'ART_WUP_LEVEL'
         ELSE NULL
         END = 'ART_LEVEL'
       THEN DCA.manual_price_art
       WHEN CASE
         WHEN SC.discount_type_name = 'second_discount'
         THEN 'ART_WUP_LEVEL'
         WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
         THEN 'ART_LEVEL'
         WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
         THEN 'ART_WUP_LEVEL'
         ELSE NULL
         END = 'ART_WUP_LEVEL'
       THEN DPC.manual_price_art_wup
       ELSE NULL
       END <= COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
    THEN CASE
     WHEN CASE
       WHEN SC.discount_type_name = 'second_discount'
       THEN 'ART_WUP_LEVEL'
       WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
       THEN 'ART_LEVEL'
       WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
       THEN 'ART_WUP_LEVEL'
       ELSE NULL
       END = 'ART_LEVEL'
     THEN DCA.manual_price_art
     WHEN CASE
       WHEN SC.discount_type_name = 'second_discount'
       THEN 'ART_WUP_LEVEL'
       WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
       THEN 'ART_LEVEL'
       WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
       THEN 'ART_WUP_LEVEL'
       ELSE NULL
       END = 'ART_WUP_LEVEL'
     THEN DPC.manual_price_art_wup
     ELSE NULL
     END
    ELSE CASE
     WHEN SC.model_price_gross_local_val IS NULL
     THEN COALESCE(VPS.previous_submitted_price, SC.selling_price_gross_local_val)
     ELSE SC.model_price_gross_local_val
     END
    END, 2) / (1 + MWST_PER.mwst / 100) AS manual_markdown_price_netto,
  CASE
  WHEN SC.mandant_id = 1
  THEN 0
  ELSE 1
  END AS checkbox_zr_default
FROM kfl_production_dbp_view.v_nfmd_article_store_scorecard_2 AS SC
 INNER JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_approved_decision_2 AS FIN ON SC.mandant_id = FIN.mandant_id AND SC.art_id
      = FIN.art_id AND SC.kjwo_ww = FIN.kjwo_ww AND FIN.markdown_decision_id = 0
 INNER JOIN kfl_production_dbp_view.v_art_2 AS ART_2 ON SC.art_id = ART.art_id AND SC.mandant_id = ART.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS MWST_PER_2 ON ART.mwst_id = MWST_PER.mwst_id AND ART.mandant_id =
    MWST_PER.mandant_id AND MWST_PER.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_nfmd_parameter_2 AS PRMS ON FIN.mandant_id = PRMS.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_art_price_2 AS DCA ON FIN.kjwo_ww = DCA.kjwo_ww AND FIN.art_id
    = DCA.art_id AND FIN.mandant_id = DCA.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_art_price_dat_2 AS DCVF ON FIN.kjwo_ww = DCVF.kjwo_ww AND FIN.art_id
     = DCVF.art_id AND FIN.mandant_id = DCVF.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_comments_2 AS COMM ON FIN.kjwo_ww = COMM.kjwo_ww AND FIN.art_id = COMM
    .art_id AND FIN.mandant_id = COMM.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_art_wup_price_2 AS DPC ON SC.mandant_id = DPC.mandant_id AND SC
     .kjwo_ww = DPC.kjwo_ww AND SC.art_id = DPC.art_id AND SC.wup_id = DPC.wup_id
 LEFT JOIN kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_art_wup_price_dat_2 AS DDC ON SC.mandant_id = DDC.mandant_id
    AND SC.kjwo_ww = DDC.kjwo_ww AND SC.art_id = DDC.art_id AND SC.wup_id = DDC.wup_id
 LEFT JOIN kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_article_article_cluster_rel_2 AS ART_CLUST ON FIN.kjwo_ww =
    ART_CLUST.kjwo_ww AND FIN.art_id = ART_CLUST.art_id AND FIN.mandant_id = ART_CLUST.mandant_id
 LEFT JOIN kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_loaded_art_wup_values_2 AS VPS ON SC.kjwo_ww = VPS.kjwo_ww AND
      SC.aktion_id = VPS.aktion_id AND SC.mandant_id = VPS.mandant_id AND SC.art_id = VPS.art_id AND SC.wup_id = VPS.wup_id
   
WHERE FIN.markdown_decision_id = 0;
