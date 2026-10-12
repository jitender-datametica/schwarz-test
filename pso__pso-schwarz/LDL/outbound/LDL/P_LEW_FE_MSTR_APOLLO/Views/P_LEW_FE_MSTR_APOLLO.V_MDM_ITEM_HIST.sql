/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_HIST
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski, Michal           Initial Version
#  1.1  16.02.2023    Rayanki, Aparna              Adapted Core changes
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_item_hist (client_id, mdm_item_sid, cbx_item_version_nr,
cbx_item_doc_status, cbx_item_change_tmsp, market_sid, item_fam_grp_sid, brand_sid, country_pol_sid_origin, mdm_sup_sid
, ean_ownership_cd, sup_final_fg, item_workflow_status_id, item_class_cd, buy_status_cd, display_type_cd, hier_node_sid
, item_collection, item_notes, guarantee_cd, guarantee_type_cd, guarantee_art, item_quality_class_cd, mdm_pillar_sid,
main_pillar_cd, kfl_brand_sid, mdm_item_split_role_cd, mdm_list_type_cd, mdm_item_split_method_cd, innovation_fg,
season_name, catalog_fg, cancel_reason_name, initial_range_plan_cd, ldl_relevant_fg, kfl_relevant_fg, package_type_cd,
controlled_price_fg, item_highlight_fg, initial_order_fg, item_unit_uom_sid, item_unit_uom_cd, item_unit_qty,
minimal_order_qty, item_initiating_int_org_sid, item_proposing_int_org_sid, case_size_qty, contract_expiry_dt,
mdm_item_composition_cd, mdm_case_composition_cd, item_unit_cnt, item_variant_cnt, quality_comment_txt,
purch_comment_txt, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id
 ,
 mdm_item_sid,
 cbx_item_version_nr,
 cbx_item_doc_status,
 cbx_item_change_tmsp,
 market_sid,
 item_fam_grp_sid,
 brand_sid,
 country_pol_sid_origin,
 mdm_sup_sid,
 ean_ownership_cd,
 sup_final_fg,
 item_workflow_status_id,
 item_class_cd,
 buy_status_cd,
 display_type_cd,
 hier_node_sid,
 item_collection,
 item_notes,
 guarantee_cd,
 guarantee_type_cd,
 guarantee_art,
 item_quality_class_cd,
 mdm_pillar_sid,
 main_pillar_cd,
 kfl_brand_sid,
 mdm_item_split_role_cd,
 mdm_list_type_cd,
 mdm_item_split_method_cd,
 innovation_fg,
 season_name,
 catalog_fg,
 cancel_reason_name,
 initial_range_plan_cd,
 ldl_relevant_fg,
 kfl_relevant_fg,
 package_type_cd,
 controlled_price_fg,
 item_highlight_fg,
 initial_order_fg,
 item_unit_uom_sid,
 item_unit_uom_cd,
 item_unit_qty,
 minimal_order_qty,
 item_initiating_int_org_sid,
 item_proposing_int_org_sid,
 case_size_qty,
 contract_expiry_dt,
 mdm_item_composition_cd,
 mdm_case_composition_cd,
 item_unit_cnt,
 item_variant_cnt,
 quality_comment_txt,
 purch_comment_txt,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core_ac.v_mdm_item_hist;