CREATE OR REPLACE DYNAMIC TABLE  P_LEW_MART_MSI.V_AGG_INV_ITEM_WH_DAY_2
(
    client_id
    ,loc_sid
    ,wh_id
    ,item_id
    ,dat_formdate
    ,diff_inv_stc_calc_cnt
    ,diff_inv_stc_calc_val
    ,diff_inv_stc_calc_net_val
    ,diff_inv_qty
    ,diff_inv_val
    ,diff_inv_net_val
    ,diff_inv_return_qty
    ,diff_inv_return_val
    ,diff_inv_return_net_val
    ,gross_prcs_calc
    ,net_prcs_calc
)
TARGET_LAG = '1 hour, 30 minutes' -- dummy_2 value; will be refreshed by Abinitio job
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
    COALESCE(inv.client_id   , itm.client_id   ) AS client_id
   ,COALESCE(inv.loc_sid     , itm.loc_sid     ) AS loc_sid
   ,COALESCE(inv.wh_id       , itm.wh_id         ) AS wh_id
   ,COALESCE(inv.item_id    , itm.item_id    )   AS item_id
   ,COALESCE(inv.dat_formdate, itm.booking_dat ) AS dat_formdate
   ,SUM(COALESCE(inv.inv_diff_total_piece, 0)   + COALESCE(itm.ship_qty , 0))     AS diff_inv_stc_calc_cnt
   ,SUM(COALESCE(inv.inv_diff_total_val  , 0)   + COALESCE(itm.gross_val, 0))     AS diff_inv_stc_calc_val
   ,SUM(COALESCE(inv.inv_diff_total_net_val, 0) + COALESCE(itm.sales_net_val, 0)) AS diff_inv_stc_calc_net_val
   ,inv.inv_diff_total_piece                     AS diff_inv_qty
   ,inv.inv_diff_total_val                       AS diff_inv_val
   ,inv.inv_diff_total_net_val                   AS diff_inv_net_val
   ,itm.ship_qty                                 AS diff_inv_return_qty
   ,itm.gross_val                                AS diff_inv_return_val
   ,itm.sales_net_val                            AS diff_inv_return_net_val
   ,SUM(COALESCE(inv.inv_diff_total_val, 0) + COALESCE(itm.gross_val, 0)) / CASE WHEN SUM(COALESCE(inv.inv_diff_total_piece, 0) + COALESCE(itm.ship_qty, 0)) = 0 THEN NULL ELSE SUM(COALESCE(inv.inv_diff_total_piece, 0) + COALESCE(itm.ship_qty, 0)) END AS gross_prcs_calc
   ,SUM(COALESCE(inv.inv_diff_total_net_val, 0) + COALESCE(itm.sales_net_val, 0)) / CASE WHEN SUM(COALESCE(inv.inv_diff_total_piece, 0) + COALESCE(itm.ship_qty, 0)) = 0 THEN NULL ELSE SUM(COALESCE(inv.inv_diff_total_piece, 0) + COALESCE(itm.ship_qty, 0)) END AS net_prcs_calc
   FROM p_lew_mart_msi.v_agg_inv_diff_item_wh_day_2 AS inv
   FULL OUTER JOIN p_lew_mart_msi.v_agg_inv_return_item_wh_day_2 AS itm
   ON  inv.client_id   = itm.client_id
   AND inv.item_id = itm.item_id
   AND inv.loc_sid = itm.loc_sid
   AND inv.dat_formdate = itm.booking_dat
GROUP BY 1,2,3,4,5,9,10,11,12,13,14
;