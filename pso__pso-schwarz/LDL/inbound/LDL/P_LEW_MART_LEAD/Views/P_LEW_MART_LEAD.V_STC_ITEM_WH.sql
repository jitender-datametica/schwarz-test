CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_STC_ITEM_WH
AS
   /*
   #DescStart#
   #$Revision: 11490 $, $LastChangedBy: ckumbhale $
   #SubjectAreas#: COEX stock for warehouse
   #DescEnd#
   */
   SELECT
      sli.client_id                                             AS client_id,
   cry.curr_cd_from                                          AS currency_iso_cd,
   sli.dwh_cal_dt                                            AS dat_formdate,
   sli.item_sid                                              AS item_id,
    sli.price / cry.exchange_rate::DECIMAL(18,4) AS price_retail_stc_wh,
    sli.price_net  / cry.exchange_rate::DECIMAL(19,5) AS price_retail_net_stc_wh,
   sli.stock_calc_qty                                        AS qty_piece_stc_wh,
   wh.src_wh_id                                              AS wh_id,
   wh.loc_sid_wh                                             AS loc_sid_wh
  FROM p_lew_bil_ac.v_stock_location_item AS sli
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh
   ON  sli.client_id     = wh.client_id
   AND sli.loc_sid       = wh.loc_sid_wh
   AND wh.dwh_actual_fg  = 1
   AND wh.bges_active_fg = 1
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
   # selection of partitions
   */
   WHERE sli.dwh_cal_dt <= CURRENT_DATE
     AND sli.client_id < 41
;