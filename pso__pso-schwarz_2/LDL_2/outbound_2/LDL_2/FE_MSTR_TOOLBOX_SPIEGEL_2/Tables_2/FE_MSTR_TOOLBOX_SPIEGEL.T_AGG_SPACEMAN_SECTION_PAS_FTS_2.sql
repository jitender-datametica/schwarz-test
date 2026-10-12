/*
#----------------------------------------------------------------------------
# Description:
# This table provides the agreggated KPIs on section level.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_fe_mstr_toolbox_spiegel.t_agg_spaceman_section_pas_fts_2 (
int_org_sid BIGNUMERIC(38,0),
spaceman_section_sid BIGNUMERIC(38,0),
section_width_meas BIGNUMERIC(38,11),
shelf_width_meas BIGNUMERIC(38,11),
max_potential_contact_distance BIGNUMERIC(38,12),
max_potential_contact_distance_5 BIGNUMERIC(38,12),
avg_kolli BIGNUMERIC(38,12),
avg_einzel BIGNUMERIC(38,12),
cnt_cases BIGNUMERIC(38,0),
cnt_item_2 BIGNUMERIC(38,0),
section_selection_id BIGNUMERIC(38,0),
metric_system_id BIGNUMERIC(38,0),
pas_type STRING(20),
higher_meas BIGNUMERIC(38,0),
shelf_meter BIGNUMERIC(38,6)
);