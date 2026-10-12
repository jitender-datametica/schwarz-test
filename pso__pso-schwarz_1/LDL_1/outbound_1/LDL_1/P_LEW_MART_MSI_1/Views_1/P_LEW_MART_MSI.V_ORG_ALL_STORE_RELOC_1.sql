CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_org_all_store_reloc_1 AS SELECT move_to_st_loc_sid AS move_to_store_id,
 st_loc_sid AS store_id,
 store_desc,
 client_id,
 orig_store_nr,
 move_fg
FROM ldl_p_lew_core_ac.v_wawi_org_all_store_reloc_act_1;