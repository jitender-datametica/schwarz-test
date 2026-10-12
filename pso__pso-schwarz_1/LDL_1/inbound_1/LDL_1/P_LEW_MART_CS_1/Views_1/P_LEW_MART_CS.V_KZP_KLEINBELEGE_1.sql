/* 
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS.V_KZP_KLEINBELEGE_1
#----------------------------------------------------------------------------
# History:
#
#  V#   When       Who                         What
#  1.0  26.02.2021    Wachauf, Christian       Add filter on v_gen_item_hist_1 (only valid items considered) and item_Deleted_fg    
#  1.1  15.03.2021    Guenes, Oguzhan          Transfer to Snowflake.
#                                              https://jira.schwarz/browse/DDLE-1783
#                                              Create scripts for snowflake standardisation.
#  1.2  24.06.2021    Ross, Ulrich             Remove deleted_fg in subSelect for v_gen_item_hist_1 to get all items 
#  1.3  30.03.2022    Ross, Ulrich             Fix missing Kleinbelege while stores closed; User Story 306764
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_KZP_KLEINBELEGE_1
(
client_id
,country_iso_cd
,dat_formdate
,cy_month
,orig_item_nr
,orig_store_nr
,qty_total_sfo_asis
,qty_total_sfo_wrtoff_zero_asis
,sfotype_id
,val_rtl_rcptline_sfo_asis
,val_rtl_rcptline_net_sfo_asis
,val_wrtoff_zero_asis
,val_wrtoff_zero_net_asis
,price_wh_sfo_asis
,price_wh_net_sfo_asis
,price_str_sfo_asis
,price_str_net_sfo_asis
,currency_iso_cd
)
AS
SELECT
agg.client_id                                                        AS client_id
, t.src_country_lidl_cd                                              AS country_iso_cd
, agg.booking_dat                                                    AS dat_formdate
, agg.cy_month                                                       AS cy_month
, Coalesce(item.orig_item_nr, -1)                                    AS orig_item_nr
, Coalesce(store.src_orig_store_nr, -1)                              AS orig_store_nr
, SUM(agg.qty_total_sfo_asis)                                        AS qty_total_sfo_asis
, SUM(agg.qty_total_sfo_wrtoff_zero_asis)                            AS qty_total_sfo_wrtoff_zero_asis
, agg.sfotype_id                                                     AS sfotype_id
, CAST(SUM(agg.val_rtl_rcptline_sfo_asis) AS DECIMAL(18,4))          AS val_rtl_rcptline_sfo_asis
, CAST(SUM(agg.val_rtl_rl_net_sfo_asis) AS DECIMAL(18,4))            AS val_rtl_rcptline_net_sfo_asis
, CAST(SUM(agg.val_wrtoff_zero_asis) AS DECIMAL(18,4))               AS val_wrtoff_zero_asis
, CAST(SUM(agg.val_wrtoff_zero_net_asis) AS DECIMAL(18,4))           AS val_wrtoff_zero_net_asis
, CAST(MAX(agg.price_wh_sfo_asis) AS DECIMAL(18,4))                  AS price_wh_sfo_asis
, CAST(MAX(agg.price_wh_net_sfo_asis) AS DECIMAL(18,4))              AS price_wh_net_sfo_asis
, CAST(MAX(agg.price_str_sfo_asis) AS DECIMAL(18,4))                 AS price_str_sfo_asis
, CAST(MAX(agg.price_str_net_sfo_asis) AS DECIMAL(18,4))             AS price_str_net_sfo_asis
, agg.currency_iso_cd                                                AS currency_iso_cd
FROM p_lew_mart_cs.v_gen_agg_store_day_item_sfo_asis_1 AS agg

-- Country_1
INNER JOIN p_lew_core_ac.v_client_1 c
ON agg.client_id = c.client_id

INNER JOIN p_lew_core_ac.v_country_1 t
ON c.country_sid = t.country_sid

LEFT OUTER JOIN (   SELECT client_id, item_sid, orig_item_nr
                    FROM P_LEW_MART_CS.v_gen_item_hist_1
                    WHERE CURRENT_DATE - 1 BETWEEN valid_from AND valid_until
                    GROUP BY 1,2,3) item_1
ON item.client_id = agg.client_id
AND item.item_sid = agg.item_sid_map

INNER JOIN
    (SELECT client_id, src_orig_store_nr
     FROM p_lew_mart_cs.v_gen_kzp_store_1 
     GROUP BY client_id, src_orig_store_nr) AS store
ON store.client_id = agg.client_id
AND store.src_orig_store_nr = agg.src_orig_store_nr

GROUP BY 1,2,3,4,5,6,9,18
;