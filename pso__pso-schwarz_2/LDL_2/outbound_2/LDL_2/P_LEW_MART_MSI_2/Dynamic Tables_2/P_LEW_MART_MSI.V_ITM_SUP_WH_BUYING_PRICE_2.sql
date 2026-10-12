CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_itm_sup_wh_buying_price_2 AS
SELECT SUP.client_id,
 VLMK.src_wh_id AS wh_id,
 SUP.item_sid AS item_id,
 SUP.sup_sid AS supplier_id,
 SUP.dat_rec_start,
 SUP.dat_rec_end,
 SUP.dat_valid_from,
 SUP.dat_valid_until,
 SUP.dat_valid_until_group,
 SUP.curr_sid AS currency_nr,
 SUP.currency_nr_special,
 SUP.group_nr,
 SUP.delivery_item_cd,
 SUP.dur_shelflife_cust,
 SUP.period_id_shelflife_cust,
 SUP.dur_shelflife_store,
 SUP.period_id_shelflife_store,
 SUP.dur_shelflife_wh,
 SUP.period_id_shelflife_wh,
 SUP.price_buying,
 SUP.price_buying_special
FROM ldl_p_lew_bil_ac.v_itm_sup_wh_buying_price_2 AS SUP
 INNER JOIN ldl_p_lew_core_ac.v_location_2 AS VLMK ON SUP.wh_loc_sid = VLMK.loc_sid
WHERE CURRENT_DATE BETWEEN SUP.dat_rec_start AND SUP.dat_rec_end;