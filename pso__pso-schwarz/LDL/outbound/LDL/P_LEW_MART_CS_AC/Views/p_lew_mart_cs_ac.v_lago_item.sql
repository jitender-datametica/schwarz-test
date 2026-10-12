CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_lago_item (client_id, country_iso_cd, item_id, orig_item_nr,
orig_item_nr_int, case_size_lago, valid_from, valid_until, brand_name, item_actiongroup_id, item_sub_actiongroup_id,
is_plu_item, buying_list_type_id, plu_nr, unitsize, buying_employee_skey, buying_employee_name, subitemgroup_id,
int_subitemgroup_id, itemstatus_cd, packagetype_desc, item_familygroup_id, cs_updated, cs_created, cs_load_id) AS SELECT
 *
FROM ldl_p_lew_mart_cs.v_lago_item AS I;