/* NEW */ /* NEW */ /* NEW */ /* NEW */ /* NEW */ /* NEW */
CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_spaceman_section_item_store_aisle_pas_fts_2 (int_org_sid,
spaceman_section_sid, spaceman_item_sid, cases, mult_pos_cases, mult_pos_einzel, cases_einzel, placing,
item_merchandising_type_cd, cnt_item_2, cnt_cases, avg_kolli, avg_einzel, avg_contact_distance_per_item,
avg_facings_per_item, potential_1, potential_1_in_cm, potential_1_in_cm_einzel, cnt_facings, cnt_facings_reduced,
cnt_facings_reduced_einzel, capacity, section_selection_id, metric_system_id, pas_type, higher_meas, shelf_meter,
client_id, move_to_store_id, aisle) AS SELECT KPI.int_org_sid,
 KPI.spaceman_section_sid,
 KPI.spaceman_item_sid,
 KPI.cases,
 KPI.mult_pos_cases /* NEW */,
 KPI.mult_pos_einzel /* NEW */,
 KPI.cases_einzel /* NEW */,
 KPI.placing,
 KPI.item_merchandising_type_cd /* NEW */,
 KPI.cnt_item_2,
 KPI.cnt_cases,
 KPI.avg_kolli,
 KPI.avg_einzel,
 KPI.avg_contact_distance_per_item,
 KPI.avg_facings_per_item,
 KPI.potential_1,
 KPI.potential_1_in_cm,
 KPI.potential_1_in_cm_einzel,
 KPI.cnt_facings,
 KPI.cnt_facings_reduced,
 KPI.cnt_facings_reduced_einzel /* NEW */,
 KPI.capacity,
 KPI.section_selection_id,
 KPI.metric_system_id,
 KPI.pas_type /* NEW */,
 KPI.higher_meas,
 KPI.shelf_meter,
 STORE.client_id,
 STORE.move_to_store_id,
 SSA.aisle
FROM ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_section_item_pas_fts_2 AS KPI
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_store_2 AS SECSTORE ON KPI.spaceman_section_sid = SECSTORE.spaceman_section_sid
  
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_org_store_merge_vges_2 AS STORE ON SECSTORE.loc_sid_store = STORE.store_id
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_store_aisle_2 AS SSA ON SECSTORE.spaceman_section_sid = SSA.spaceman_section_sid
    AND STORE.move_to_store_id = SSA.move_to_store_id;