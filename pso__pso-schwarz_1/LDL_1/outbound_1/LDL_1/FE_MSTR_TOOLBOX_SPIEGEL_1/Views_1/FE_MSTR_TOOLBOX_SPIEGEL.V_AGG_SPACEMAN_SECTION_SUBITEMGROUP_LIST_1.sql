/*
#----------------------------------------------------------------------------
# Description:
# This view provides the existing subitemgroups for all sections (separated with comma)
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_section_subitemgroup_list_1 (spaceman_section_sid,
subitemgroup_list) AS SELECT spaceman_section_sid,
 subitemgroup_list
FROM ldl_fe_mstr_toolbox_spiegel.t_agg_spaceman_section_subitemgroup_list_1;