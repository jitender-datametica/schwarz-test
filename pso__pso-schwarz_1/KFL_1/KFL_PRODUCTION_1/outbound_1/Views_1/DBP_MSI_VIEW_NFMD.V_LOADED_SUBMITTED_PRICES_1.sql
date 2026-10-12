-- Data with manual changes
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.v_loaded_submitted_prices_1 AS WITH
 SUBMIT_TABLE_BASE AS (SELECT DISTINCT kjwo_ww,
   mandant_id,
   aktion_id,
   art_id,
   wup_id,
   manual_promo_price_gross_local_val,
   manual_promo_price_dt,
   dwh_created_tmsp,
   DENSE_RANK() OVER (PARTITION BY CAST(kjwo_ww AS STRING), CAST(mandant_id AS STRING), aktion_id, CAST(art_id AS STRING)
      , CAST(wup_id AS STRING) ORDER BY manual_promo_price_dt IS NULL, manual_promo_price_dt) AS markdown
  FROM kfl_production_dbp_msi_view_nfmd.ts_nfmd_manual_price_release_1
  ORDER BY kjwo_ww DESC NULLS FIRST), SAP_WB AS (SELECT mandant_id,
   MAX(execution_tmsp) AS timestamp_sap
  FROM kfl_production_dbp_view.v_nfmd_pipeline_export_log_1
  GROUP BY mandant_id), ID40 AS (SELECT DISTINCT kjwo_ww,
   mandant_id,
   aktion_id,
   art_id,
   wup_id,
   selling_price_gross_local_val
  FROM kfl_production_dbp_view.v_nfmd_article_store_scorecard_1) (-- SAP Load	max time per Mandant_1

  -- Basetable - Scorecard
 -- to_char(weekiso(v01.valid_from_date), 'FM00') AS test_1,
 SELECT v01.mandant_id,
   v01.art_id,
   v01.wup_id,
   v01.kjwo_ww,
   v01.aktion_id,
   v03.selling_price_gross_local_val AS initialer_vk,
   v01.manual_promo_price_gross_local_val AS neuer_vk,
   ROUND(v01.manual_promo_price_gross_local_val / v03.selling_price_gross_local_val, 4) AS rabatt,
   v01.manual_promo_price_dt AS valid_from,
     CAST(CAST(EXTRACT(YEAR FROM v01.manual_promo_price_dt) AS STRING) || TRIM(CAST(EXTRACT(ISOWEEK FROM v01.manual_promo_price_dt) AS STRING FORMAT '00')
        ) AS FLOAT64) - v01.kjwo_ww + 1 AS woche_rabatt,
   v01.markdown AS anzahl_markdowns
  FROM SUBMIT_TABLE_BASE AS v01
   INNER JOIN SAP_WB AS v02 ON v01.mandant_id = v02.mandant_id AND v01.dwh_created_tmsp < v02.timestamp_sap
     -- Only data that transferred to SAP

   INNER JOIN ID40 AS v03 ON v01.mandant_id = v03.mandant_id AND v01.kjwo_ww = v03.kjwo_ww AND v01.wup_id = v03.wup_id
     AND v01.aktion_id = v03.aktion_id AND v01.art_id = v03.art_id);