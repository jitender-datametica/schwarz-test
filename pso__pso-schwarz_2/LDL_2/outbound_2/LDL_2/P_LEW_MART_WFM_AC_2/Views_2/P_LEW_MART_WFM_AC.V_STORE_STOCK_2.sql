/* #DescStart#
#$Revision: 9175 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_store_stock_2 (client_id, 
  wh_id, 
  orig_store_nr, 
  orig_item_nr, 
  dat_formdate, 
  qty_stc_calc, 
  dat_formdate_14, 
  qty_stc_calc_14, 
  min_dat_formdate_14) 
AS SELECT client_id,
 wh_id,
 orig_store_nr,
 orig_item_nr,
 dat_formdate,
 qty_stc_calc,
 dat_formdate_14,
 qty_stc_calc_14,
 min_dat_formdate_14
FROM ldl_p_lew_mart_wfm.v_store_stock_2;