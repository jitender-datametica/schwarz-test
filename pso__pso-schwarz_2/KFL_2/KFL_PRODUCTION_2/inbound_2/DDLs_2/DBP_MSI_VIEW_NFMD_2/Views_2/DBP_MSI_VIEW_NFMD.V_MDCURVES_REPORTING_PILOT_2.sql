CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.V_MDCURVES_REPORTING_PILOT_2 AS 
WITH SAP_TIME AS (
    SELECT MANDANT_ID, MAX(EXECUTION_TMSP) AS letzte_uebertragung
    FROM DBP_VIEW.V_NFMD_PIPELINE_EXPORT_LOG_2
    GROUP BY mandant_id
)

SELECT CTR.CTRL_V_TEST_CD AS CTRL_V_TREATMENT,
       COALESCE(md2.markdown_decision_descr, 'None')  AS submitted_decesion,
       curv.ART_ID,
       curv.WUP_ID,
       COALESCE(art_spr.ART_BEZ, 'N/A')   AS SKU_NAME,
       mdw.WUP_NAME_E                AS WUP_NAME,
      'nicht mehr vorhanden'       AS WUP_CLUSTER,
       ri.VSVT_BEZ          AS WUP_REGION,
       ri.VS_BEZ             AS REGION_2,
       curv.CURVE_WEEK_NR AS CURVE_WEEK,
       fs.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL AS SUBMITTED_PRICE,
       CASE
           WHEN fs.DWH_CREATED_TMSP <= SAP_TIME.letzte_uebertragung
               THEN fs.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL END       AS SUBMITTED_AND_LOADED_PRICE,
       fs.DWH_CREATED_TMSP AS VALID_FROM_DATE,
       ROUND(fs.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL / CURV.SELLING_PRICE_GROSS_LOCAL_VAL, 4) AS discount,
       ps.NB_OF_MARKDOWNS AS NB_OF_MARKDOWN,
       CASE
           WHEN fs.MODEL_PRICE_GROSS_LOCAL_VAL <> fs.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL THEN 'Overwritten'
           WHEN fs.MODEL_PRICE_GROSS_LOCAL_VAL = fs.MANUAL_PROMO_PRICE_GROSS_LOCAL_VAL THEN 'Model recommendation' END AS overwritten,
       curv.AKTION_ID,
       curv.promo_start_dt AS  AKTION_DAT_VON,
       --curv.CALENDAR_YEAR,
      -- curv.CALENDAR_WEEK,
       curv.kjwo_ww promoweek,
       curv.SELLING_PRICE_GROSS_LOCAL_VAL AS VK_AKTION_BRUTTO,
       curv.WRG_ID AS CURRENCY,
       COALESCE(hwg_spr.HWG_BEZ,'N/A')   AS HWG_BEZ,
       COALESCE(owg_spr.owg_bez, 'N/A')  AS OWG_BEZ,
       COALESCE(wg_spr.wg_bez,'N/A')     AS WG_BEZ,
       COALESCE(wug_spr.wug_bez, 'N/A')  AS WUG_BEZ,
       curv.STOCK_INITIAL_CNT AS STOCK_INITIAL,
       curv.WEEKLY_SALES_CNT AS SALES_2,
       curv.CUMULATED_SALES_CNT AS CUMULATED_SALES,
       curv.WEEKLY_REVENUE_GROSS_LOCAL_VAL AS REVENUE,
       curv.WEEKLY_SELL_RATE AS  SELL_RATIO,
       curv.WEEKLY_PRICE_RATE AS PRICE_RATIO,
       art.MUTTER_WB_ID AS  WERBEMUTTER_ID, -- über die ART_2 Tabelle 
       curv.MANDANT_ID,
       curv.MODEL_EXECUTION_TMSP AS MODEL_DATE,
       curv.MODEL_EXECUTION_TMSP AS model_date_format,
       curv.AI_MODEL_ID AS MODEL_ID
FROM DBP_VIEW.V_NFMD_ARTICLE_STORE_CURVES_2 curv
    -- CORE.SRC_HDP_MD_CURVES_MASTER_REPORTING_2 curv
    JOIN DBP_MSI_VIEW_NFMD.CONTROLL_VS_TREATMENT_2 ctr ON CURV.WUP_ID = ctr.WUP_ID
    LEFT JOIN sap_time
        ON curv.mandant_id = sap_time.mandant_id 
        LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_ARTICLE_STORE_SCORECARD_2 id40
    --- MV_FRONTEND_ID40_WB_2 id40
                   ON curv.KJWO_WW = id40.KJWO_WW AND
                      curv.MANDANT_ID = id40.MANDANT_ID AND
                      CURV.AKTION_ID = id40.AKTION_ID AND
                      curv.ART_ID = id40.ART_ID AND
                      CURV.WUP_ID = id40.WUP_ID
		 LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_LOADED_ART_WUP_VALUES_2 ps 
    -- FE_MSTR_NFMD.MV_PRODUCT_STATISTICS_2 ps
                   ON curv.kjwo_ww = ps.kjwo_ww AND
                      curv.MANDANT_ID = ps.MANDANT_ID AND
                      CURV.AKTION_ID = ps.AKTION_ID AND
                      curv.ART_ID = ps.ART_ID AND
                      CURV.WUP_ID = ps.WUP_ID
    
     --   LEFT JOIN
    -- (SELECT SKU_ID, MAX(SKU_NAME) AS SKU_NAME FROM FE_MSTR_NFMD.MV_FRONTEND_ID40_WB_2 GROUP BY 1) max_sku
    -- ON curv.ART_ID = max_sku.SKU_ID
    --     LEFT JOIN
    -- (SELECT WUP_ID,
    --         MAX(WUP_NAME)    AS WUP_NAME,
    --         MAX(WUP_CLUSTER) AS WUP_CLUSTER,
    --         MAX(WUP_REGION)  AS WUP_REGION,
     --        MAX(REGION_2)      AS REGION_2
     -- FROM FE_MSTR_NFMD.MV_FRONTEND_ID40_WB_2
     -- GROUP BY 1) max_wup
    -- ON curv.WUP_ID = max_wup.WUP_ID -- 
        JOIN DBP_MSI_VIEW_NFMD.MV_WERBEWOCHE_KL_2 ld
    -- FE_MSTR_NFMD.MV_LOOKUP_DATES_2 ld
                   ON curv.kjwo_ww = ld.kjwo_ww
                       AND curv.mandant_id = ld.mandant_id
        JOIN DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION_2 id30
    -- CORE.TS_ID30_MSI_FINAL_SUBMIT_2 id30
                   ON curv.KJWO_WW = id30.KJWO_WW AND
                      curv.MANDANT_ID = id30.MANDANT_ID AND
                      CURV.AKTION_ID = id30.AKTION_ID AND
                      curv.ART_ID = id30.ART_ID  AND 
                       id30.MARKDOWN_DECISION_iD = 0 -- NUR wo ein Markdown stattgefunden hat    
        JOIN  DBP_MSI_VIEW_NFMD.TS_NFMD_MARKDOWN_DECISION_2 md2 ON
    -- CORE.L_MARKDOWN_DECISION md2 ON
    (id30.MARKDOWN_DECISION_ID = md2.MARKDOWN_DECISION_ID AND id30.mandant_id = md2.mandant_id)
    
         LEFT JOIN DBP_MSI_VIEW_NFMD.TS_NFMD_MANUAL_PRICE_RELEASE_2 fs 
     -- CORE.TS_ID40_FINAL_SUBMIT_2 fs
                   ON curv.KJWO_WW = fs.KJWO_WW
                       AND curv.MANDANT_ID = fs.MANDANT_ID
                       AND curv.AKTION_ID = fs.AKTION_ID
                       AND CURV.ART_ID = fs.ART_ID
                       AND CURV.WUP_ID = fs.WUP_ID
                       AND CASE
                               WHEN DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) < 7 THEN 1
                               WHEN DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) >= 7 AND
                                    DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) < 14 THEN 2
                               WHEN DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) >= 14 AND
                                    DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) < 21 THEN 3
                               WHEN DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) >= 21 AND
                                    DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) < 28 THEN 4
                               WHEN DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) >= 28 AND
                                    DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) < 35 THEN 5
                               WHEN DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) >= 35 AND
                                    DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) < 42 THEN 6
                               WHEN DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) >= 42 AND
                                    DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) < 49 THEN 7
                               WHEN DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) >= 49 AND
                                    DATEDIFF('day', ld.ww_dat_von, fs.MANUAL_PROMO_PRICE_DT) < 56 THEN 8
                               END = curv.curve_week_nr
        
         LEFT JOIN DBP_VIEW.V_WUP_2 mdw
                   ON curv.WUP_ID = mdw.WUP_ID
                       AND curv.MANDANT_ID = mdw.MANDANT_ID
         LEFT JOIN DBP_VIEW.V_VS_2 ri
                   ON mdw.VS_ID = ri.VS_ID
                       AND mdw.MANDANT_ID = ri.MANDANT_ID
        --- ARTIKEL_2 STRUKTUR
        LEFT JOIN DBP_VIEW.V_ART_2 art_2
            ON curv.mandant_id = art.mandant_id
            AND curv.art_id = art.art_id
        LEFT JOIN DBP_VIEW.V_ART_SPR_ZU_2 art_spr
            ON art.art_id = art_spr.art_id
            AND art.mandant_id = art_spr.mandant_id
            AND art_spr.spr_id = 22 -- deutsch 
        -- WG & WUG_2 ID 
        LEFT JOIN DBP_VIEW.V_ART_WG_ZU_PER_2 wg_zu_per
            ON art.mandant_id = wg_zu_per.mandant_id
            AND art.art_id = wg_zu_per.art_id
            AND wg_zu_per.arthiertyp_id = 2 
            AND wg_zu_per.dat_bis = '9999-12-31'
        -- 
        LEFT JOIN DBP_VIEW.V_WG_SPR_ZU_2 wg_spr
            ON wg_zu_per.wg_id = wg_spr.wg_id
            AND WG_ZU_PER.MANDANT_ID = WG_SPR.MANDANT_ID
            AND WG_ZU_PER.arthiertyp_id = WG_SPR.arthiertyp_id
            AND WG_SPR.SPR_ID = 22 -- deutsch
         LEFT JOIN DBP_VIEW.V_WUG_SPR_ZU_2 wug_spr
            ON wg_zu_per.wg_id = wug_spr.wg_id
            AND WG_ZU_PER.MANDANT_ID = wug_spr.MANDANT_ID
            AND WG_ZU_PER.WUG_ID = wug_spr.WUG_ID
            AND WG_ZU_PER.arthiertyp_id = wug_spr.arthiertyp_id
            AND wug_spr.SPR_ID = 22 -- deutsch   
        --- OWG 
        LEFT JOIN DBP_VIEW.V_WG_PER_2 wg_per_2 
            ON wg_zu_per.mandant_id = wg_per.mandant_id
            AND wg_zu_per.arthiertyp_id = wg_per.arthiertyp_id
            AND wg_zu_per.wg_id = wg_per.wg_id
            AND wg_per.dat_bis = '9999-12-31'
        LEFT JOIN DBP_VIEW.V_OWG_SPR_ZU_2 owg_spr
            ON wg_per.mandant_id = owg_spr.mandant_id
            AND wg_per.arthiertyp_id = owg_spr.arthiertyp_id
            AND wg_per.owg_id = owg_spr.owg_id
            AND owg_spr.spr_id = 22 -- deutsch 
        --- HWG
        LEFT JOIN DBP_VIEW.V_OWG_PER_2 owg_per_2
            ON wg_per.mandant_id = owg_per.mandant_id
            AND wg_per.arthiertyp_id = owg_per.arthiertyp_id
            AND wg_per.owg_id = owg_per.owg_id
            AND owg_per.dat_bis = '9999-12-31'
        LEFT JOIN dbp_view.v_hwg_spr_zu_2 hwg_spr
            ON owg_per.mandant_id = hwg_spr.mandant_id
            AND owg_per.arthiertyp_id = hwg_spr.arthiertyp_id
            AND owg_per.hwg_id = hwg_spr.hwg_id
            AND hwg_spr.spr_id = 22 -- deutsch 
;