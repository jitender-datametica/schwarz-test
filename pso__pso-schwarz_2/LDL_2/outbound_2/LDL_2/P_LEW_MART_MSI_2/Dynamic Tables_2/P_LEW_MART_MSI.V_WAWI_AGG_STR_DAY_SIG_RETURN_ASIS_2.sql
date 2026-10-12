CREATE OR REPLACE TABLE ldl_p_lew_mart_msi.v_wawi_agg_str_day_sig_return_asis_2 AS
SELECT AGG.client_id,
 AGG.st_loc_sid AS loc_sid_store,
 WH.orig_wh_nr AS wh_id,
 AGG.subitemgroup_id,
 AGG.dat_formdate,
 AGG.return_receipttype_id,
 AGG.return_reason_cd_ejr_sfo,
 AGG.qty_return_ejr_sfo,
  AGG.val_return_ejr_sfo / CURRH.exchange_rate AS val_return_ejr_sfo,
  AGG.val_return_net_ejr_sfo / CURRH.exchange_rate AS val_return_net_ejr_sfo,
 CURRH.curr_cd_from AS currency_iso_cd,
 1 AS sysind
FROM ldl_p_lew_core_ac.v_wawi_agg_str_day_sig_return_asis_2 AS AGG
 INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_2 AS WH ON AGG.client_id = WH.client_id AND AGG.st_loc_sid = WH.loc_sid_store
      AND WH.dwh_actual_fg = 1 AND WH.active_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CURRH ON AGG.client_id = CURRH.client_id AND CURRENT_DATE
    BETWEEN CURRH.active_from_dt AND CURRH.active_to_dt AND CURRENT_DATE BETWEEN CURRH.dwh_valid_from AND CURRH.dwh_valid_to
   
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS CURRT ON CURRH.client_id = CURRT.client_id AND CURRH.x_rate_type_sid
     = CURRT.x_rate_type_sid AND CURRT.src_kurst = '@BEWE';