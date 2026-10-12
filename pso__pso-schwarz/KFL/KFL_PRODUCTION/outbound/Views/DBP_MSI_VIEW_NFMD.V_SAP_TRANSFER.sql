CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.v_sap_transfer AS WITH COUNTRY_CODES AS (SELECT mandant_id,
   land_id
  FROM kfl_production_dbp_view.v_wup
  GROUP BY mandant_id,
   land_id), LAST_TRANSFER AS (SELECT mandant_id,
   MAX(execution_tmsp) AS last_transfer_sap
  FROM kfl_production_dbp_view.v_nfmd_pipeline_export_log
  GROUP BY mandant_id), INSERT_BASE AS (SELECT LEFT(SUBSTR(CAST(IFS.kjwo_ww AS STRING), 1, 39), 4) AS year_id,
   RIGHT(SUBSTR(CAST(IFS.kjwo_ww AS STRING), 1, 39), 2) AS week_id,
   IFS.mandant_id,
   IFS.aktion_id,
   TDART.kl_art_id,
   IFS.wup_id,
   IFS.wrg_id,
   IFS.dwh_created_tmsp,
   IFS.manual_promo_price_gross_local_val,
   IFS.manual_promo_price_dt,
   t1.land_id,
   IFS.discount_type_name,
    CASE
    WHEN IFS.discount_type_name = 'second_discount'
    THEN SSC.second_discount_end_dt
    ELSE DATE_ADD(IFS.manual_promo_price_dt, INTERVAL CAST(PRMS.validity_days_cnt AS INTEGER) DAY)
    END AS valid_to_date,
   ROW_NUMBER() OVER (PARTITION BY IFS.aktion_id, CAST(IFS.art_id AS STRING), CAST(IFS.wup_id AS STRING) ORDER BY IFS.dwh_created_tmsp
      IS NULL DESC, IFS.dwh_created_tmsp DESC) AS row_num
  FROM kfl_production_dbp_msi_view_nfmd.ts_nfmd_manual_price_release AS IFS
   INNER JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_approved_decision AS ID_30 ON IFS.kjwo_ww = ID_30.kjwo_ww AND IFS
       .mandant_id = ID_30.mandant_id AND IFS.art_id = ID_30.art_id AND ID_30.markdown_decision_id = 0
   INNER JOIN (SELECT DISTINCT *
    FROM COUNTRY_CODES AS cc) AS t1 ON IFS.mandant_id = t1.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_nfmd_parameter AS PRMS ON IFS.mandant_id = PRMS.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_nfmd_article_store_scorecard AS SSC ON IFS.kjwo_ww = SSC.kjwo_ww AND IFS.mandant_id
          = SSC.mandant_id AND IFS.wup_id = SSC.wup_id AND IFS.art_id = SSC.art_id AND IFS.aktion_id = SSC.aktion_id AND
     IFS.discount_type_name = SSC.discount_type_name
   LEFT JOIN kfl_production_dbp_view.v_art AS TDART ON IFS.art_id = TDART.art_id AND IFS.mandant_id = TDART.mandant_id
   LEFT JOIN LAST_TRANSFER AS SAP ON IFS.mandant_id = SAP.mandant_id
  WHERE IFS.dwh_created_tmsp > COALESCE(SAP.last_transfer_sap, CAST('1900-01-01 00:00:00' AS DATETIME))) (SELECT
   mandant_id AS mandt,
   wup_id AS werks,
   kl_art_id AS matnw,
   'ZNFM' AS kschl,
   DATE(manual_promo_price_dt) AS kodatab,
   valid_to_date AS kodatbi,
   manual_promo_price_gross_local_val AS kbetr,
   wrg_id AS konwa,
   land_id,
   dwh_created_tmsp AS updated_at
  FROM INSERT_BASE
  WHERE row_num = 1);