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


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_section_pas_fts_1 (int_org_sid, spaceman_section_sid,
section_width_meas, shelf_width_meas, max_potential_contact_distance, max_potential_contact_distance_5, avg_kolli,
avg_einzel, cnt_cases, cnt_item_1, section_selection_id, metric_system_id, pas_type, higher_meas, shelf_meter) AS SELECT
 int_org_sid,
 spaceman_section_sid,
 section_width_meas,
 shelf_width_meas,
 max_potential_contact_distance,
 max_potential_contact_distance_5,
 avg_kolli,
 avg_einzel,
 cnt_cases,
 cnt_item_1,
 section_selection_id,
 metric_system_id,
 pas_type,
 higher_meas,
 shelf_meter
FROM ldl_fe_mstr_toolbox_spiegel.t_agg_spaceman_section_pas_fts_1;