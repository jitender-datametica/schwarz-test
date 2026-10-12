/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup of group level 1
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_group_level_1_2 (section_group_level_1_nr,
section_group_level_1_name, int_org_sid) AS SELECT section_group_level_1_nr,
 section_group_level_1_name,
 int_org_sid
FROM ldl_p_lew_core_ac.v_spaceman_section_group_level_1_hist_2 AS LVL
WHERE dwh_valid_to = DATE '9999-12-30'
 AND deleted_fg = 0;