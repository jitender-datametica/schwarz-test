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


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_mat_agg_spaceman_section_subitemgroup_list (spaceman_section_sid
OPTIONS(description='Section ID'), subitemgroup_list
OPTIONS(description='All existing subitemgroups for all sections (separated with comma)')) AS SELECT t3.spaceman_section_sid
 ,
 STRING_AGG(CAST(t3.subitemgroup_id AS STRING), ',') AS subitemgroup_list
FROM (SELECT DISTINCT SEC.spaceman_section_sid,
   ITEM.subitemgroup_id
  FROM ldl_p_lew_core_ac.v_spaceman_section AS SEC
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_shelf AS SHELF ON SEC.spaceman_section_sid = SHELF.spaceman_section_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_shelf_position AS POS ON SHELF.shelf_sid = POS.shelf_sid
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_shelf_position_hist AS POSHIST ON POS.shelf_position_sid = POSHIST.shelf_position_sid
    
   INNER JOIN ldl_p_lew_core_ac.v_spaceman_item AS SPIT ON POSHIST.spaceman_item_sid = SPIT.spaceman_item_sid
   INNER JOIN ldl_p_lew_core_ac.v_item_spaceman_item AS ITSPIT ON SPIT.spaceman_item_sid = ITSPIT.spaceman_item_sid
   INNER JOIN ldl_p_lew_mart_lead_ac.v_itm_item AS ITEM ON ITSPIT.item_sid = ITEM.item_id
   INNER JOIN ldl_p_lew_core_ac.v_item_hist AS ITEMHIST ON ITEM.item_id = ITEMHIST.item_sid
  WHERE POSHIST.dwh_valid_to = DATE '9999-12-30'
   AND ITEMHIST.dwh_valid_to = DATE '9999-12-30'
   AND POSHIST.deleted_fg = 0
   AND ITEMHIST.deleted_fg = 0
   AND SPIT.active_to_dt = DATE '9999-12-30'
   AND ITEM.subitemgroup_id >= 0
  ORDER BY SEC.spaceman_section_sid NULLS LAST,
   ITEM.subitemgroup_id NULLS LAST) AS t3
GROUP BY t3.spaceman_section_sid;