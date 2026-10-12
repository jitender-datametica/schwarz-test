/* 
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_FILIALANLIEFERUNGEN
#----------------------------------------------------------------------------
# History:
# V#   When          Who                   What
# 1.0  26.02.2021    Wachauf, Christian    Add filter on v_gen_item_hist (only valid items considered)     
# 1.1  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                          https://jira.schwarz/browse/DDLE-1783
#                                          Create scripts for snowflake standardisation.
# 1.3  24.06.2021    Ross, Ulrich          Remove deleted_fg in subSelect for v_gen_item_hist to get all items 
# 1.4  30.03.2022    Ross, Ulrich          Fix missing Filalanlieferungen while stores closed; User Story 306764
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_KZP_FILIALANLIEFERUNGEN
(
  client_id
, country_iso_cd
, dat_formdate
, cy_month
, deliverytype_id
, orig_item_nr
, src_orig_store_nr
, qty_total_del_asis
, val_rtl_rl_del_asis
, val_rtl_rl_net_del_asis
, qty_piece_del_asis
, val_piece_del_asis
, val_piece_net_del_asis
, val_pr_diff_del
, val_pr_diff_net_del
, currency_iso_cd
)
AS
SELECT
agg.client_id
, t.src_country_lidl_cd                                             AS country_iso_cd
, agg.dat_formdate
, agg.cy_month
, agg.deliverytype_id
, COALESCE(item.orig_item_nr, -1)                                   AS orig_item_nr
, COALESCE(store.src_orig_store_nr, -1)                             AS src_orig_store_nr
, CAST(SUM(agg.qty_total_del_asis) AS DECIMAL(18,4))                AS qty_total_del_asis
, CAST(SUM(agg.val_rtl_rl_del_asis) AS DECIMAL(18,4))               AS val_rtl_rl_del_asis
, CAST(SUM(agg.val_rtl_rl_net_del_asis) AS DECIMAL(18,4))           AS val_rtl_rl_net_del_asis
, CAST(SUM(agg.qty_piece_del_asis) AS DECIMAL(18,4))                AS qty_piece_del_asis
, CAST(SUM(agg.val_piece_del_asis) AS DECIMAL(18,4))                AS val_piece_del_asis
, CAST(SUM(agg.val_piece_net_del_asis) AS DECIMAL(18,4))            AS val_piece_net_del_asis
, COALESCE(CAST(SUM(agg.val_pr_diff_del) AS DECIMAL(18,4)),0)       AS val_pr_diff_del
, COALESCE(CAST(SUM(agg.val_pr_diff_net_del) AS DECIMAL(18,4)),0)   AS val_pr_diff_net_del
, agg.currency_iso_cd
FROM p_lew_mart_cs.v_gen_agg_store_day_item_del_asis AS agg

LEFT OUTER JOIN ( SELECT client_id, item_sid, orig_item_nr
                  FROM p_lew_mart_cs.v_gen_item_hist
                  WHERE CURRENT_DATE - 1 BETWEEN valid_from AND valid_until
                  GROUP BY 1,2,3) item
ON item.client_id = agg.client_id
AND item.item_sid = agg.item_sid_map
-- Country
INNER JOIN p_lew_core_ac.v_client c
ON item.client_id = c.client_id

INNER JOIN p_lew_core_ac.v_country t
ON c.country_sid = t.country_sid

INNER JOIN
    (SELECT client_id, loc_sid_store, src_orig_store_nr
     FROM p_lew_mart_cs.v_gen_kzp_store 
     WHERE src_wh_id <> src_orig_store_nr
     GROUP BY client_id, loc_sid_store, src_orig_store_nr) AS store
ON store.client_id = agg.client_id
AND store.loc_sid_store = agg.loc_sid_store

GROUP BY 1,2,3,4,5,6,7,16
;