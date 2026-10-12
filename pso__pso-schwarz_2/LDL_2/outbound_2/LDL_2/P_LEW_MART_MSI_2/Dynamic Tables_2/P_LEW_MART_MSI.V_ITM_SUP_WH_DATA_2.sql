CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_itm_sup_wh_data_2 AS
SELECT SUP.client_id,
 SUP.sup_sid AS supplier_id,
 SUP.item_sid AS item_id,
 WH.src_wh_id AS wh_id,
 SUP.dat_rec_start,
 SUP.dat_rec_end,
 SUP.currency_nr,
 SUP.delivery_item_cd,
 SUP.dat_valid_from,
 SUP.dat_valid_until,
 SUP.active_fg,
 SUP.delete_fg,
 SUP.dur_shelflife_cust,
 SUP.period_id_shelflife_cust,
 SUP.factor_period_cust,
 SUP.dur_shelflife_store,
 SUP.period_id_shelflife_store,
 SUP.factor_period_store,
 SUP.dur_shelflife_wh,
 SUP.period_id_shelflife_wh,
 SUP.factor_period_wh
FROM ldl_p_lew_core_ac.v_wawi_itm_sup_wh_data_2 AS SUP
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON SUP.client_id = WH.client_id AND SUP.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
WHERE CURRENT_DATE BETWEEN SUP.dat_rec_start AND SUP.dat_rec_end
 AND SUP.delete_fg <> 2;