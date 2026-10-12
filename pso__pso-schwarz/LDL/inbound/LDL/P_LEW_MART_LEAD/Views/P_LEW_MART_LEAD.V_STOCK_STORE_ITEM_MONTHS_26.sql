CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_STOCK_STORE_ITEM_MONTHS_26
AS
   SELECT
     sli.client_id                                     AS client_id,
   sli.loc_sid                                       AS loc_sid              --store_id
   ,
   stw_l.src_wh_id                                   AS src_wh_id            --wh_id
   ,
   stw_l.loc_sid_wh                                  AS loc_sid_wh,
   sli.item_sid                                      AS item_sid             --item_id
   ,
   sli.calc_qty                                      AS stock_calc_qty       --qty_stc_calc
   ,
   sli.inv_qty                                       AS stock_inv_qty        --qty_stc_inv
   ,
   CASE WHEN ZeroIfNull(sli.diff_qty_inv_calc) = 0
         THEN sli.calc_qty
         ELSE sli.inv_qty
    END                                               AS stock_real_qty,
   sli.diff_qty_inv_calc                             AS stock_inv_diff_calc  --diff_stc_inv_calc
   ,
    sli.price     / cry.exchange_rate::DECIMAL(18,4) AS cond_val_eff_calc    --price_retail
   ,
    sli.price_net / cry.exchange_rate::DECIMAL(19,5) AS net_val_eff_calc     --price_retail_net
   ,
   cry.curr_cd_from                                  AS curr_cd              --currency_iso_cd
   ,
   cry.curr_sid_from                                 AS curr_sid,
   sli.dwh_valid_from                                AS dwh_valid_from,
   sli.dwh_valid_to                                  AS dwh_valid_to

  FROM p_lew_core_ac.v_item_location_stock_hist AS sli
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown AS stw_l
   ON  sli.client_id = stw_l.client_id
   AND sli.loc_sid   = stw_l.loc_sid_store
   /*
   # exclude the dummy stores for warehouse  
   */
   AND sli.loc_sid  <> stw_l.loc_sid_wh
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS cry
   ON  sli.client_id = cry.client_id
   /*
   # latest rate (point in history)  
   */
   AND CURRENT_DATE BETWEEN cry.active_from_dt AND cry.active_to_dt
   /*
   # latest history (version)
   */
   AND CURRENT_DATE BETWEEN cry.dwh_valid_from AND cry.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_exchange_rate_type AS ert
   ON  cry.client_id       = ert.client_id
   AND cry.x_rate_type_sid = ert.x_rate_type_sid
   /*
   # reporting rate (slow moving)
   */
   AND ert.src_kurst       = '@BEWE'

   /*
   # selection of dates for past 26 month // Datuemer der letzen 26 Monate
   */
   WHERE sli.dwh_valid_from <=DATE'9999-12-30'
     AND ADD_MONTHS(CURRENT_DATE,-26)- EXTRACT(DAY FROM ADD_MONTHS(CURRENT_DATE,-26)) +1 <= sli.dwh_valid_to
;