CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_item_skey AS SELECT client_id,
 item_sid AS item_id,
 orig_item_nr,
 case_size,
 reused_nr
FROM ldl_p_lew_core_ac.v_wawi_itm_item_skey_act;