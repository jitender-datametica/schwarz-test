CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_itm_orig_item_2 (client_id, orig_item_nr, dat_valid_from, item_fam_grp_sid,
item_familygroup_id, orig_item_nr_int, sub_item_grp_sid, subitemgroup_id, dwh_updated) AS SELECT client_id,
 orig_item_nr,
 dat_valid_from,
 item_fam_grp_sid,
 item_familygroup_id,
 orig_item_nr_int,
 sub_item_grp_sid,
 subitemgroup_id,
 dwh_updated
FROM ldl_p_lew_mart_lead.t_itm_orig_item_2;