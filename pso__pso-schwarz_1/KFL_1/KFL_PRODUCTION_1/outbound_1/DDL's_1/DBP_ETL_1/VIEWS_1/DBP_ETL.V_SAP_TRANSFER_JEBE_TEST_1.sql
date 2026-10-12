CREATE OR REPLACE VIEW kfl_production_dbp_etl.v_sap_transfer_jebe_test_1 AS WITH COUNTRY_CODES AS (SELECT mandant_id,
   land_id
  FROM kfl_production_dbp_view.v_wup_1
  GROUP BY mandant_id,
   land_id), LAST_TRANSFER AS (SELECT mandant_id,
   MAX(execution_tmsp) AS last_transfer_sap
  FROM kfl_production_dbp_view.v_nfmd_pipeline_export_log_1
  GROUP BY mandant_id), INSERT_BASE AS (SELECT LEFT(SUBSTR(CAST(IFS.kjwo_ww AS STRING), 1, 10), 4) AS year_id,
   RIGHT(SUBSTR(CAST(IFS.kjwo_ww AS STRING), 1, 10), 2) AS week_id,
   IFS.mandant_id,
   IFS.aktion_id,
   TDART.kl_art_id,
   TDART.art_id,
   IFS.wup_id,
   IFS.wrg_id,
   IFS.dwh_created_tmsp,
   IFS.manual_promo_price_gross_local_val,
   IFS.manual_promo_price_dt,
   t1.land_id,
   DATE_ADD(IFS.manual_promo_price_dt, INTERVAL CAST(PRMS.validity_days_cnt AS INTEGER) DAY) AS valid_to_date,
   ROW_NUMBER() OVER (PARTITION BY IFS.aktion_id, IFS.art_id, IFS.wup_id ORDER BY IFS.dwh_created_tmsp IS NULL DESC, IFS
      .dwh_created_tmsp DESC) AS row_num
  FROM kfl_production_dbp_msi_view_nfmd.ts_nfmd_manual_price_release_1 AS IFS
   INNER JOIN kfl_production_dbp_msi_view_nfmd.ts_nfmd_approved_decision_1 AS ID_30 ON IFS.kjwo_ww = ID_30.kjwo_ww AND IFS
       .mandant_id = ID_30.mandant_id AND IFS.art_id = ID_30.art_id AND ID_30.markdown_decision_id = 0
   INNER JOIN (SELECT DISTINCT *
    FROM COUNTRY_CODES AS cc) AS t1_1 ON IFS.mandant_id = t1.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_nfmd_parameter_1 AS PRMS ON IFS.mandant_id = PRMS.mandant_id
    /* LEFT JOIN KFL_PRODUCTION.DBP_VIEW.V_NFMD_ARTICLE_STORE_SCORECARD_1 ssc ON 
    -- CORE.SRC_HDP_FRONTEND_SCREEN_SCORECARD_1 ssc ON -- warum ?? 
	(ifs.KJWO_WW = ssc.KJWO_WW
	AND ifs.MANDANT_ID = ssc.MANDANT_ID
	AND ifs.WUP_ID = ssc.WUP_ID
	AND ifs.ART_ID = ssc.ART_ID
    AND ifs.AKTION_ID = ssc.AKTION_ID 
    ) */
    -- wird nicht mehr benoetigt - Gueltig bis nun nicht ab AKtion_1 Start sondern ab Gueltig ab

    /* JOIN KFL_PRODUCTION.dbp_view.v_aktion_1 aktion_1 
    ON aktion.mandant_id = ifs.mandant_id
    AND aktion.kjwo_von = ifs.kjwo_ww
    AND aktion.aktion_id = ifs.aktion_id */
    
   LEFT JOIN kfl_production_dbp_view.v_art_1 AS TDART ON IFS.art_id = TDART.art_id
    -- AND ifs.MANDANT_ID = tdart.MANDANT_ID

   LEFT JOIN LAST_TRANSFER AS SAP ON IFS.mandant_id = SAP.mandant_id
  WHERE IFS.dwh_created_tmsp > COALESCE(SAP.last_transfer_sap, CAST('1900-01-01 00:00:00' AS DATETIME))) (/* COUNTRY_1 CODES */
  /* Date FROM last transfer */ /* Combine Submissions with Country_1 Codes */ -- CORE.TS_ID40_FINAL_SUBMIT_1 ifs

  -- Nur die Artikel_1 die zum Zeitpunkt der Uebertragung Markodwn haben
 -- CORE.TS_ID30_MSI_FINAL_SUBMIT_1 ID_30
 SELECT
   row_num,
   mandant_id AS mandt,
   wup_id AS werks,
   kl_art_id AS matnw,
   art_id,
   'ZNFM' AS kschl,
   DATE(manual_promo_price_dt) AS kodatab,
   valid_to_date AS kodatbi,
   manual_promo_price_gross_local_val AS kbetr,
   wrg_id AS konwa,
   land_id,
   dwh_created_tmsp AS updated_at
  FROM INSERT_BASE);