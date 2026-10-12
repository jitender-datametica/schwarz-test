/*
#----------------------------------------------------------------------------
# Description:
# This view provides the agreggated KPIs on section level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  2.0     10.10.2024      Simeon Nikolaev          PAS_TYPE
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_section_store_aisle_pas_fts_2 (int_org_sid,
spaceman_section_sid, section_width_meas, shelf_width_meas, max_potential_contact_distance,
max_potential_contact_distance_5, avg_kolli, cnt_cases, cnt_item_2, section_selection_id, metric_system_id, pas_type,
higher_meas, shelf_meter, client_id, move_to_store_id, aisle) AS SELECT KPI.int_org_sid,
 KPI.spaceman_section_sid,
 KPI.section_width_meas,
 KPI.shelf_width_meas,
 KPI.max_potential_contact_distance,
 KPI.max_potential_contact_distance_5,
 KPI.avg_kolli,
 KPI.cnt_cases,
 KPI.cnt_item_2,
 KPI.section_selection_id,
 KPI.metric_system_id,
 KPI.pas_type,
 KPI.higher_meas,
 KPI.shelf_meter,
 STORE.client_id,
 STORE.move_to_store_id,
 SSA.aisle
FROM ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_section_pas_fts_2 AS KPI
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_store_2 AS SECSTORE ON KPI.spaceman_section_sid = SECSTORE.spaceman_section_sid
  
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_org_store_merge_vges_2 AS STORE ON SECSTORE.loc_sid_store = STORE.store_id
 INNER JOIN ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_store_aisle_2 AS SSA ON SECSTORE.spaceman_section_sid = SSA.spaceman_section_sid
    AND STORE.move_to_store_id = SSA.move_to_store_id;