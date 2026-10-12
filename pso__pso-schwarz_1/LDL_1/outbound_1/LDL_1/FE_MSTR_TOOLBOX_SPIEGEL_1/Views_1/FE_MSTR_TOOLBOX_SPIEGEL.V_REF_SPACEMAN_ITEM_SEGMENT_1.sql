/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup of spaceman item_1 segment.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_ref_spaceman_item_segment_1 (spaceman_item_segment_sid,
spaceman_item_segment_name) AS SELECT spaceman_item_segment_sid,
 spaceman_item_segment_name
FROM ldl_p_lew_core_ac.v_ref_spaceman_item_segment_1 AS ITEMSEG;