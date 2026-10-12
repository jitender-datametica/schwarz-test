CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_itm_orig_item_1 (client_id, orig_item_nr, dat_valid_from, item_fam_grp_sid
, item_familygroup_id, orig_item_nr_int, sub_item_grp_sid, subitemgroup_id, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_itm_orig_item_1;