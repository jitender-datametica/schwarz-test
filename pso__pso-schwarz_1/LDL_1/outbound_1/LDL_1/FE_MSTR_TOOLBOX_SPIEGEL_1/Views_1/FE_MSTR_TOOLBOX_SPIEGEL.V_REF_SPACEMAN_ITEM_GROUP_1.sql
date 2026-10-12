/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup of spaceman item_1 group.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_ref_spaceman_item_group_1 (spaceman_item_grp_sid,
spaceman_item_grp_name) AS SELECT spaceman_item_grp_sid,
 spaceman_item_grp_name
FROM ldl_p_lew_core_ac.v_ref_spaceman_item_group_1 AS ITEMGR;