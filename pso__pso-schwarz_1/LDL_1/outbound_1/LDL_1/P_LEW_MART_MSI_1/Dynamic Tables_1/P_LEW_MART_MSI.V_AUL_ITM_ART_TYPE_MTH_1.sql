CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_aul_itm_art_type_mth_1
OPTIONS(DESCRIPTION = 'NUR WAWI! $Revision: 16815 $. AUTO GENERATED THURSDAY, SEPTEMBER 7, 2017 , NUR WAWI! $Revision: 16815 $. AUTO GENERATED THURSDAY, SEPTEMBER 7, 2017 ', ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
)
AS
SELECT ITM.client_id,
 ITM.item_sid AS item_id,
 M.cy_month,
 ITM.buying_list_type_id,
 ITM.buying_list_type_desc
FROM ldl_p_lew_core_ac.v_wawi_itm_item_1 AS ITM
 INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS M ON DATE_SUB(IF(PARSE_DATE('%Y%m%d', SAFE_CAST(M.cy_month as STRING) ||
       SAFE_CAST(1 as STRING)) = LAST_DAY(PARSE_DATE('%Y%m%d', SAFE_CAST(M.cy_month as STRING) || SAFE_CAST(1 as STRING)
        )), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SAFE_CAST(M.cy_month as STRING) || SAFE_CAST(1 as STRING)), INTERVAL
      1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SAFE_CAST(M.cy_month as STRING) || SAFE_CAST(1 as STRING)), INTERVAL 1
     MONTH)), INTERVAL 1 DAY) BETWEEN ITM.dat_rec_start AND ITM.dat_rec_end
WHERE M.cy_month_seq <= 0;

