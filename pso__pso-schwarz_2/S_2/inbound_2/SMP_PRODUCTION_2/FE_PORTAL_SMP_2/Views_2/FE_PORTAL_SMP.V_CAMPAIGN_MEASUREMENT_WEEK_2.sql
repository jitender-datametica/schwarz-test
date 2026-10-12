create or replace view SMP_PRODUCTION.FE_PORTAL_SMP.V_CAMPAIGN_MEASUREMENT_WEEK_2(
	CY_WEEK,
	CAMPAIGN_ID,
	ADVERTISER_ID,
	SOURCE_SYSTEM_ID,
	ADVERTISER_ID_SMP,
	ADVERTISER_ID_PIQ,
	CAMPAIGN_NAME,
	CAMPAIGN_START_DT,
	CAMPAIGN_END_DT,
	CHANNEL_ID,
	BUDGET_VAL,
	ATTRIBUTION_START_DT,
	ATTRIBUTION_END_DT,
	GTIN_ASSIGNED_LIST,
	CAMPAIGN_TYPE_ID,
	CAMPAIGN_STATUS_ID,
	BID_VAL,
	CAMPAIGN_ID_EXT,
	COUNTRY_ID,
	DIVISION_ID,
	SALES_QTY,
	SALES_VAL,
	BID_AVG_VAL,
	BUDGET_SPENT_VAL,
	IMPRESSION_QTY,
	VIEW_QTY,
	CLICK_QTY,
	SHOPPER_QTY,
	CONVERSION_QTY,
	RETAIL_BASELINE_PCT,
	RETAIL_HALO_PCT,
	VIEW_FREQUENCY_PCT,
	CLICK_THROUGH_PCT,
	CONVERSION_PCT,
	ROAS_PCT,
	CAMPAIGN_LAST_MODIFIED
) as 
SELECT
   w.CY_WEEK
  ,w.CAMPAIGN_ID
  ,w.ADVERTISER_ID
  ,w.SOURCE_SYSTEM_ID
  ,COALESCE(e.ADVERTISER_ID_SMP_SPLIT, w.ADVERTISER_ID_SMP) AS ADVERTISER_ID_SMP_
  ,w.ADVERTISER_ID_PIQ
  ,w.CAMPAIGN_NAME
  ,w.CAMPAIGN_START_DT
  ,w.CAMPAIGN_END_DT
  ,COALESCE(cm.CHANNEL_ID_MAP, w.CHANNEL_ID) AS CHANNEL_ID 
  ,w.BUDGET_VAL
  ,w.ATTRIBUTION_START_DT
  ,w.ATTRIBUTION_END_DT
  ,w.GTIN_ASSIGNED_LIST
  ,w.CAMPAIGN_TYPE_ID
  ,w.CAMPAIGN_STATUS_ID 
  ,w.ADVERTISER_BID_VAL AS BID_VAL
  ,w.CAMPAIGN_ID_EXT
  ,w.COUNTRY_ID
  ,w.DIVISION_ID
  ,w.SALES_QTY
  ,w.SALES_VAL
  ,w.BID_AVG_VAL
  ,IFNULL(w.BUDGET_SPENT_VAL, 0) 
    + IFNULL(
        CASE 
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 0 
            THEN nrt.BUDGET_SPENT_VAL_1D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 1 
            THEN nrt.BUDGET_SPENT_VAL_2D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 2 
            THEN nrt.BUDGET_SPENT_VAL_3D
            ELSE NULL
        END 
        ,0) AS BUDGET_SPENT_VAL
  ,w.IMPRESSION_QTY
  ,IFNULL(w.VIEW_QTY, 0)  
    + IFNULL(
        CASE 
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 0 
            THEN nrt.VIEW_QTY_1D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 1 
            THEN nrt.VIEW_QTY_2D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 2 
            THEN nrt.VIEW_QTY_3D
            ELSE NULL
        END 
        ,0) AS VIEW_QTY
  ,IFNULL(w.CLICK_QTY, 0) 
    + IFNULL(
        CASE 
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 0 
            THEN nrt.CLICK_QTY_1D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 1 
            THEN nrt.CLICK_QTY_2D
            WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 2 
            THEN nrt.CLICK_QTY_3D
            ELSE NULL
        END 
        ,0) AS CLICK_QTY
  ,w.SHOPPER_QTY
  ,w.CONVERSION_QTY
  ,w.RETAIL_BASELINE_PCT
  ,w.RETAIL_HALO_PCT
  ,CAST(NULLIFZERO(w.VIEW_QTY/NULLIFZERO(w.SHOPPER_QTY)) AS NUMBER(18,3)) AS VIEW_FREQUENCY_PCT
  ,CAST(
    100 
    * NULLIFZERO(
        (
        IFNULL(w.CLICK_QTY, 0) 
            + IFNULL(
                CASE 
                    WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 0 
                    THEN nrt.CLICK_QTY_1D
                    WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 1 
                    THEN nrt.CLICK_QTY_2D
                    WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 2 
                    THEN nrt.CLICK_QTY_3D
                    ELSE NULL
                END 
                ,0
                )
            )
            /
            NULLIFZERO(
            IFNULL(w.VIEW_QTY, 0) 
                + IFNULL(
                    CASE 
                        WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 0 
                        THEN nrt.VIEW_QTY_1D
                        WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 1 
                        THEN nrt.VIEW_QTY_2D
                        WHEN DATEDIFF(DAY, upd_tmsp::DATE, CURRENT_DATE) = 2 
                        THEN nrt.VIEW_QTY_3D
                        ELSE NULL
                    END 
                    ,0
                    )
                )
            ) AS NUMBER(18,3)
        ) AS CLICK_THROUGH_PCT
  ,CAST(NULLIFZERO(w.CONVERSION_QTY/NULLIFZERO(w.CLICK_QTY)) AS NUMBER(18,3)) AS CONVERSION_PCT
  ,CAST(NULLIFZERO(w.SALES_VAL/NULLIFZERO(w.BUDGET_SPENT_VAL)) AS NUMBER(18,3)) AS ROAS_PCT
  ,w.CAMPAIGN_LAST_MODIFIED
FROM core.t_fact_campaign_measurement_week_2 w

-- Workaround weil SMP den Split nicht ueber die SST liefern kannt (SMST-2762)
LEFT OUTER JOIN etl_process.t_campaign_advertiser_exception_2 e
ON w.division_id = e.division_id
  AND w.country_id = e.country_id
  AND w.campaign_id = e.campaign_id 

-- mapping channel_id nach Vorgabe aus SMST-1795
LEFT OUTER JOIN etl_process.t_ref_channel_map_2 cm
ON w.division_id = cm.division_id
  AND w.country_id = cm.country_id
  AND w.channel_id = cm.channel_id 

LEFT OUTER JOIN core.v_nrt_campaign_measurement_week_2 nrt
ON w.campaign_id = nrt.campaign_id
    AND w.cy_week = nrt.cy_week

-- Filter Berechtigung in Abhaengigkeit von Umgebung_2
INNER JOIN fe_portal_smp.v_campaign_portal_permission_2 p
ON w.division_id = p.division_id
  AND w.country_id = p.country_id
  AND w.campaign_id = p.campaign_id
;
