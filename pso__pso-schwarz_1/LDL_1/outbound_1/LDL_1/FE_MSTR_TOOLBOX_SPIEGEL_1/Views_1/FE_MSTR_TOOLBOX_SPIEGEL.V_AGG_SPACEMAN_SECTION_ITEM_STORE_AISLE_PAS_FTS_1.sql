/*
#----------------------------------------------------------------------------
# Description:
# This view provides the agreggated KPIs on section, item_1, store and aisle level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  2.0     10.10.2024      Simeon Nikolaev          PAS_TYPE/MULT_POS_CASES/MULT_POS_EINZEL/CASES_EINZEL/ITEM_MERCHANDISING_TYPE_CD/CNT_FACINGS_REDUCED_EINZEL
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_section_item_store_aisle_pas_fts_1 (int_org_sid,
spaceman_section_sid, spaceman_item_sid, cases, mult_pos_cases, mult_pos_einzel, cases_einzel, placing,
item_merchandising_type_cd, cnt_item_1, cnt_cases, avg_kolli, avg_einzel, avg_contact_distance_per_item,
avg_facings_per_item, potential_1, potential_1_in_cm, potential_1_in_cm_einzel, cnt_facings, cnt_facings_reduced,
cnt_facings_reduced_einzel, capacity, section_selection_id, metric_system_id, pas_type, higher_meas, shelf_meter,
client_id, move_to_store_id, aisle) AS SELECT int_org_sid,
 spaceman_section_sid,
 spaceman_item_sid,
 cases,
 mult_pos_cases,
 mult_pos_einzel,
 cases_einzel,
 placing,
 item_merchandising_type_cd,
 cnt_item_1,
 cnt_cases,
 avg_kolli,
 avg_einzel,
 avg_contact_distance_per_item,
 avg_facings_per_item,
 potential_1,
 potential_1_in_cm,
 potential_1_in_cm_einzel,
 cnt_facings,
 cnt_facings_reduced,
 cnt_facings_reduced_einzel,
 capacity,
 section_selection_id,
 metric_system_id,
 pas_type,
 higher_meas,
 shelf_meter,
 client_id,
 move_to_store_id,
 aisle
FROM ldl_fe_mstr_toolbox_spiegel.t_agg_spaceman_section_item_store_aisle_pas_fts_1;