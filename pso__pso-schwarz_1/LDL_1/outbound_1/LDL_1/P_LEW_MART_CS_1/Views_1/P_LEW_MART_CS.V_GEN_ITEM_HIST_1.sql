/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_gen_item_hist_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_item_hist_1 (client_id, item_sid, item_sid_config, orig_item_nr,
orig_item_nr_int, item_familygroup_id, subitemgroup_id, int_subitemgroup_id, item_actiongroup_id,
item_sub_actiongroup_id, case_size, src_country_lidl_cd, language_iso_cd, valid_from, valid_until, buying_employee_skey
, buying_employee_name, brand_name, itemstatus_cd, packagetype_desc, case_euro, case_plu_fg, plu_nr, buying_list_type_id
, buying_list_type_desc, unitsize, vat_id, smallest_unit, weight_fg, dangerous_goods_fg, deleted_fg, dwh_updated,
dwh_created, dwh_load_id, load_id, src_id) AS SELECT client_id,
 item_sid,
 item_sid_config,
 orig_item_nr,
 orig_item_nr_int,
 item_familygroup_id,
 subitemgroup_id,
 int_subitemgroup_id,
 item_actiongroup_id,
 item_sub_actiongroup_id,
 case_size,
 src_country_lidl_cd,
 language_iso_cd,
 valid_from,
 valid_until,
 buying_employee_skey,
 buying_employee_name,
 brand_name,
 itemstatus_cd,
 packagetype_desc,
 case_euro,
 case_plu_fg,
 plu_nr,
 buying_list_type_id,
 buying_list_type_desc,
 unitsize,
 vat_id,
 smallest_unit,
 weight_fg,
 dangerous_goods_fg,
 deleted_fg,
 dwh_updated,
 dwh_created,
 dwh_load_id,
 load_id,
 src_id
FROM ldl_p_lew_mart_cs.t_gen_item_hist_1;