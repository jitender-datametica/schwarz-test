CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_inv_item_wh_lead_2 
AS
/* Waehrungsumrechner */ /* Waehrungsumrechner */ 
SELECT inv.client_id AS client_id,
 inv.wh_id AS wh_id,
 ITMP.item_sid_map AS item_id,
 inv.dat_dayend AS dat_dayend,
 inv.dat_formdate AS dat_formdate,
 inv.inv_id AS inv_id,
 inv.inv_type AS inv_type,
 inv.inv_desc AS inv_desc,
 inv.byr AS byr,
 inv.inv_eval_fg AS inv_eval_fg,
 inv.store_place AS store_place,
 inv.aisle_desc AS aisle_desc,
 inv.slot_nr AS slot_nr,
 inv.diff_qty_inv_wh AS diff_qty_inv_wh,
 inv.price_retail_inv_wh AS price_retail_inv_wh,
 inv.price_retail_net_inv_wh AS price_retail_net_inv_wh,
 inv.diff_inv_wh_val AS diff_inv_wh_val,
 inv.diff_inv_wh_net_val AS diff_inv_wh_net_val,
 inv.qty_case_inv_wh AS qty_case_inv_wh,
 inv.qty_piece_inv_wh AS qty_piece_inv_wh,
 inv.qty_expected_inv_wh AS qty_expected_inv_wh,
 inv.qty_total_inv_wh AS qty_total_inv_wh,
 inv.qty_ramp_inv_wh AS qty_ramp_inv_wh,
 inv.case_size_dec AS case_size_dec,
 inv.currency_iso_cd AS currency_iso_cd
FROM (SELECT STW.client_id,
    WH.src_wh_id AS wh_id,
    STW.item_sid,
    STW.dat_dayend,
    STW.dat_formdate,
    STW.inv_id,
    STW.inv_type,
    STW.inv_desc,
    STW.busyear AS byr,
    STW.inv_eval_fg,
    STW.store_place,
    STW.aisle_desc,
    STW.slot_nr,
    STW.diff_qty_inv_wh,
     STW.price_retail_inv_wh / CURR.rate_currency_exchange AS price_retail_inv_wh,
     STW.price_retail_net_inv_wh / CURR.rate_currency_exchange AS price_retail_net_inv_wh,
    IFNULL(STW.diff_qty_inv_wh * STW.price_retail_inv_wh, 0) AS diff_inv_wh_val,
    IFNULL(STW.diff_qty_inv_wh * STW.price_retail_net_inv_wh, 0) AS diff_inv_wh_net_val,
    STW.qty_case_inv_wh,
    STW.qty_piece_inv_wh,
    STW.qty_expected_inv_wh,
    STW.qty_total_inv_wh,
    STW.qty_ramp_inv_wh,
    STW.case_size_dec,
    CURR.currency_iso_cd
   FROM ldl_p_lew_core_ac.v_wawi_inv_item_wh_2 AS STW
    INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON STW.client_id = WH.client_id AND STW.wh_loc_sid = WH.loc_sid_wh AND
      WH.dwh_actual_fg = 1
    INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CURR ON STW.client_id = CURR.client_id AND
      CURRENT_DATE BETWEEN CURR.dat_rec_start AND CURR.dat_rec_end
   WHERE STW.inv_type = 'F'
   UNION DISTINCT
   SELECT INV.client_id,
    INV.wh_id,
    INV.item_id AS item_sid,
    INV.dat_formdate AS dat_dayend,
    INV.dat_formdate,
    1 AS inv_id,
    CAST(NULL AS STRING) AS inv_type,
    CAST(NULL AS STRING) AS inv_desc,
    CAST(NULL AS BIGNUMERIC) AS byr,
    CAST(NULL AS BIGNUMERIC) AS inv_eval_fg,
    CAST(NULL AS BIGNUMERIC) AS store_place,
    CAST(NULL AS STRING) AS aisle_desc,
    CAST(NULL AS BIGNUMERIC) AS slot_nr,
    INV.diff_inv_stc_calc_cnt AS diff_qty_inv_wh,
     INV.gross_prcs_calc / B.exchange_rate AS price_retail_inv_wh,
     INV.net_prcs_calc / B.exchange_rate AS price_retail_net_inv_wh,
     INV.diff_inv_stc_calc_val / B.exchange_rate AS diff_inv_wh_val,
     INV.diff_inv_stc_calc_net_val / B.exchange_rate AS diff_inv_wh_net_val,
    CAST(NULL AS NUMERIC) AS qty_case_inv_wh,
    CAST(NULL AS NUMERIC) AS qty_piece_inv_wh,
    CAST(NULL AS NUMERIC) AS qty_expected_inv_wh,
    CAST(NULL AS NUMERIC) AS qty_total_inv_wh,
    CAST(NULL AS NUMERIC) AS qty_ramp_inv_wh,
    CAST(NULL AS NUMERIC) AS case_size_dec,
    B.curr_cd_from AS currency_iso_cd
   FROM ldl_p_lew_mart_msi.v_agg_inv_item_wh_day_2 AS INV
    INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS B ON INV.client_id = B.client_id AND CURRENT_DATE BETWEEN
       B.active_from_dt AND B.active_to_dt AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
    INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
        AND C.src_kurst = '@BEWE') AS inv
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON inv.client_id = ITMP.client_id AND inv.item_sid = ITMP.item_sid;