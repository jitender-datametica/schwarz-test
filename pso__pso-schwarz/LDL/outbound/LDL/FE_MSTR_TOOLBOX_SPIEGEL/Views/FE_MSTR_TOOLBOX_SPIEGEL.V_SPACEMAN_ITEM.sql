/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup table for spaceman item
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_item (int_org_sid, spaceman_item_sid, spaceman_item_nr,
spaceman_item_name, spaceman_item_segment_sid, spaceman_item_grp_sid) AS SELECT SPITEM.int_org_sid,
 SPITEM.spaceman_item_sid,
 CAST(ROUND(CAST(SPITEM.spaceman_item_nr AS BIGNUMERIC), 0) AS BIGNUMERIC) AS spaceman_item_nr,
 SPITEMHIST.spaceman_item_name,
 SPITEMHIST.spaceman_item_segment_sid,
 SPITEMHIST.spaceman_item_grp_sid
FROM ldl_p_lew_core_ac.v_spaceman_item AS SPITEM
 INNER JOIN ldl_p_lew_core_ac.v_spaceman_item_hist AS SPITEMHIST ON SPITEM.spaceman_item_sid = SPITEMHIST.spaceman_item_sid
  
WHERE SPITEMHIST.dwh_valid_to = DATE '9999-12-30'
 AND SPITEMHIST.deleted_fg = 0;