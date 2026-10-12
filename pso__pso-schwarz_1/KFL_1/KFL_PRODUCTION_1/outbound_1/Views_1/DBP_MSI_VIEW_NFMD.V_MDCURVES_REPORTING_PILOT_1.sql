CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.v_mdcurves_reporting_pilot_1 AS WITH SAP_TIME AS (SELECT
   mandant_id,
   MAX(execution_tmsp) AS letzte_uebertragung
  FROM kfl_production_dbp_view.v_nfmd_pipeline_export_log_1
  GROUP BY mandant_id) (SELECT CTR.ctrl_v_test_cd AS ctrl_v_treatment,
   COALESCE(MD2.markdown_decision_descr, 'None') AS submitted_decesion,
   CURV.art_id,
   CURV.wup_id,
   COALESCE(ART_SPR.art_bez, 'N/A') AS sku_name,
   MDW.wup_name_e AS wup_name,
   'nicht mehr vorhanden' AS wup_cluster,
   RI.vsvt_bez AS wup_region,
   RI.vs_bez AS region_1,
   CURV.curve_week_nr AS curve_week,
   FS.manual_promo_price_gross_local_val AS submitted_price,
    CASE
    WHEN FS.dwh_created_tmsp <= t1.letzte_uebertragung
    THEN FS.manual_promo_price_gross_local_val
    ELSE NULL
    END AS submitted_and_loaded_price,
   FS.dwh_created_tmsp AS valid_from_date,
   ROUND(FS.manual_promo_price_gross_local_val / CURV.selling_price_gross_local_val, 4) AS discount,
   PS.nb_of_markdowns AS nb_of_markdown,
    CASE
    WHEN FS.model_price_gross_local_val <> FS.manual_promo_price_gross_local_val
    THEN 'Overwritten'
    WHEN FS.model_price_gross_local_val = FS.manual_promo_price_gross_local_val
    THEN 'Model recommendation'
    ELSE NULL
    END AS overwritten,
   CURV.aktion_id,
   CURV.promo_start_dt AS aktion_dat_von,
   CURV.kjwo_ww AS promoweek,
   CURV.selling_price_gross_local_val AS vk_aktion_brutto,
   CURV.wrg_id AS currency,
   COALESCE(HWG_SPR.hwg_bez, 'N/A') AS hwg_bez,
   COALESCE(OWG_SPR.owg_bez, 'N/A') AS owg_bez,
   COALESCE(WG_SPR.wg_bez, 'N/A') AS wg_bez,
   COALESCE(WUG_SPR.wug_bez, 'N/A') AS wug_bez,
   CURV.stock_initial_cnt AS stock_initial,
   CURV.weekly_sales_cnt AS sales_1,
   CURV.cumulated_sales_cnt AS cumulated_sales,
   CURV.weekly_revenue_gross_local_val AS revenue,
   CURV.weekly_sell_rate AS sell_ratio,
   CURV.weekly_price_rate AS price_ratio,
   ART.mutter_wb_id AS werbemutter_id,
   CURV.mandant_id,
   CURV.model_execution_tmsp AS model_date,
   CURV.model_execution_tmsp AS model_date_format,
   CURV.ai_model_id AS model_id
  FROM kfl_production_dbp_view.v_nfmd_article_store_curves_1 AS CURV
   INNER JOIN kfl_production_dbp_msi_view_nfmd.controll_vs_treatment_1 AS CTR ON CURV.wup_id = CTR.wup_id
   LEFT JOIN SAP_TIME AS t1_1 ON CURV.mandant_id = t1.mandant_id
   LEFT JOIN kfl_production_dbp_msi_view_nfmd.mv_nfmd_article_store_scorecard_1 AS ID40 ON CURV.kjwo_ww = ID40.kjwo_ww AND
        CURV.mandant_id = ID40.mandant_id AND CURV.aktion_id = ID40.aktion_id AND CURV.art_id = ID40.art_id AND CURV.wup_id
      = ID40.wup_id
   LEFT JOIN kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_loaded_art_wup_values_1 AS PS ON CURV.kjwo_ww = PS.kjwo_ww
       AND CURV.mandant_id = PS.mandant_id AND CURV.aktion_id = PS.aktion_id AND CURV.art_id = PS.art_id AND CURV.wup_id
      = PS.wup_id
   INNER JOIN kfl_production_dbp_msi_view_nfmd.mv_werbewoche_kl_1 AS LD ON CURV.kjwo_ww = LD.kjwo_ww AND CURV.mandant_id =
     LD.mandant_id
   INNER JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_approved_decision_1 AS ID30 ON CURV.kjwo_ww = ID30.kjwo_ww AND CURV
        .mandant_id = ID30.mandant_id AND CURV.aktion_id = ID30.aktion_id AND CURV.art_id = ID30.art_id AND ID30.markdown_decision_id
      = 0
   INNER JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_markdown_decision_1 AS MD2 ON ID30.markdown_decision_id = MD2.markdown_decision_id
      AND ID30.mandant_id = MD2.mandant_id
   LEFT JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_manual_price_release_1 AS FS ON CURV.kjwo_ww = FS.kjwo_ww AND CURV.mandant_id
          = FS.mandant_id AND CURV.aktion_id = FS.aktion_id AND CURV.art_id = FS.art_id AND CURV.wup_id = FS.wup_id AND
      CASE
      WHEN DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von, DAY) < 7
      THEN 1
      WHEN DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von, DAY) >= 7 AND DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von
         ,DAY) < 14
      THEN 2
      WHEN DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von, DAY) >= 14 AND DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von
         ,DAY) < 21
      THEN 3
      WHEN DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von, DAY) >= 21 AND DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von
         ,DAY) < 28
      THEN 4
      WHEN DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von, DAY) >= 28 AND DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von
         ,DAY) < 35
      THEN 5
      WHEN DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von, DAY) >= 35 AND DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von
         ,DAY) < 42
      THEN 6
      WHEN DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von, DAY) >= 42 AND DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von
         ,DAY) < 49
      THEN 7
      WHEN DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von, DAY) >= 49 AND DATE_DIFF(FS.manual_promo_price_dt, LD.ww_dat_von
         ,DAY) < 56
      THEN 8
      ELSE NULL
      END = CURV.curve_week_nr
   LEFT JOIN kfl_production_dbp_view.v_wup_1 AS MDW ON CURV.wup_id = MDW.wup_id AND CURV.mandant_id = MDW.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_vs_1 AS RI ON MDW.vs_id = RI.vs_id AND MDW.mandant_id = RI.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_art_1 AS ART_1 ON CURV.mandant_id = ART.mandant_id AND CURV.art_id = ART.art_id
   LEFT JOIN kfl_production_dbp_view.v_art_spr_zu_1 AS ART_SPR ON ART.art_id = ART_SPR.art_id AND ART.mandant_id = ART_SPR
      .mandant_id AND ART_SPR.spr_id = 22
   LEFT JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS WG_ZU_PER ON ART.mandant_id = WG_ZU_PER.mandant_id AND ART.art_id
        = WG_ZU_PER.art_id AND WG_ZU_PER.arthiertyp_id = 2 AND WG_ZU_PER.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_view.v_wg_spr_zu_1 AS WG_SPR ON WG_ZU_PER.wg_id = WG_SPR.wg_id AND WG_ZU_PER.mandant_id =
       WG_SPR.mandant_id AND WG_ZU_PER.arthiertyp_id = WG_SPR.arthiertyp_id AND WG_SPR.spr_id = 22
   LEFT JOIN kfl_production_dbp_view.v_wug_spr_zu_1 AS WUG_SPR ON WG_ZU_PER.wg_id = WUG_SPR.wg_id AND WG_ZU_PER.mandant_id
         = WUG_SPR.mandant_id AND WG_ZU_PER.wug_id = WUG_SPR.wug_id AND WG_ZU_PER.arthiertyp_id = WUG_SPR.arthiertyp_id
    AND WUG_SPR.spr_id = 22
   LEFT JOIN kfl_production_dbp_view.v_wg_per_1 AS WG_PER_1 ON WG_ZU_PER.mandant_id = WG_PER.mandant_id AND WG_ZU_PER.arthiertyp_id
        = WG_PER.arthiertyp_id AND WG_ZU_PER.wg_id = WG_PER.wg_id AND WG_PER.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_view.v_owg_spr_zu_1 AS OWG_SPR ON WG_PER.mandant_id = OWG_SPR.mandant_id AND WG_PER.arthiertyp_id
        = OWG_SPR.arthiertyp_id AND WG_PER.owg_id = OWG_SPR.owg_id AND OWG_SPR.spr_id = 22
   LEFT JOIN kfl_production_dbp_view.v_owg_per_1 AS OWG_PER_1 ON WG_PER.mandant_id = OWG_PER.mandant_id AND WG_PER.arthiertyp_id
        = OWG_PER.arthiertyp_id AND WG_PER.owg_id = OWG_PER.owg_id AND OWG_PER.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_view.v_hwg_spr_zu_1 AS HWG_SPR ON OWG_PER.mandant_id = HWG_SPR.mandant_id AND OWG_PER.arthiertyp_id
        = HWG_SPR.arthiertyp_id AND OWG_PER.hwg_id = HWG_SPR.hwg_id AND HWG_SPR.spr_id = 22);