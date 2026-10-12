/* #-------------------------------------------------------------------------------------------
# History:
#  1.1  09.02.2024    Chetana Patil       ADO_468229_AP0169432 - Differenzierung Rabattierung (Rabattstaffeln) 
#  1.2  23.02.2024    Chetana Patil       ADO_468229_AP0169432 - Changes  
#  1.3  14.05.2024    Chetana Patil       ADO_468229_AP0169432 - Changes  
#------------------------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_discount_ejr_2 (client_id, store_id, item_id, discount_id, dat_calendar,
discount_pct, src_discount_nr, listing_type_id_hist, buying_list_type_id_hist, src_posart, discount_descr,
first_appearance_dt, lidlplus_coupon_pattern_fg, currency_iso_cd, val_discount_net_ejr, val_discount_hq_net_ejr,
val_discount_base_net_ejr, qty_discount_pos_ejr, qty_discount_hq_ejr) AS SELECT client_id,
 store_id,
 item_id,
 discount_id,
 dat_calendar,
 discount_pct,
 src_discount_nr,
 listing_type_id_hist,
 buying_list_type_id_hist,
 src_posart,
 discount_descr,
 first_appearance_dt,
 lidlplus_coupon_pattern_fg,
 currency_iso_cd,
 val_discount_net_ejr,
 val_discount_hq_net_ejr,
 val_discount_base_net_ejr,
 qty_discount_pos_ejr,
 qty_discount_hq_ejr
FROM ldl_p_lew_mart_msi.v_discount_ejr_2;