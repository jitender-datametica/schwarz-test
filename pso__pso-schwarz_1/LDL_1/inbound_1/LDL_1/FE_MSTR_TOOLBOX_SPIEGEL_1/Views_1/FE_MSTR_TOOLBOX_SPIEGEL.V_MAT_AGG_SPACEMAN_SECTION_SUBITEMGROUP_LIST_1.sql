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

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_AGG_SPACEMAN_SECTION_SUBITEMGROUP_LIST_1
(
    spaceman_section_sid       COMMENT 'Section ID'
    ,subitemgroup_list         COMMENT 'All existing subitemgroups for all sections (separated with comma)'
)
AS
SELECT spaceman_section_sid 
     , Listagg(subitemgroup_id, ',') AS subitemgroup_list
FROM (
     SELECT DISTINCT sec.spaceman_section_sid, item.subitemgroup_id
     FROM  P_LEW_CORE_AC.v_spaceman_section_1 sec  
           INNER JOIN P_LEW_CORE_AC.v_spaceman_section_shelf_1 shelf 
           ON sec.spaceman_section_sid = shelf.spaceman_section_sid 
           INNER JOIN P_LEW_CORE_AC.v_spaceman_shelf_position_1 pos 
           ON shelf.shelf_sid = pos.shelf_sid 
           INNER JOIN P_LEW_CORE_AC.v_spaceman_shelf_position_hist_1 poshist 
           ON pos.shelf_position_sid = poshist.shelf_position_sid
           INNER JOIN P_LEW_CORE_AC.v_spaceman_item_1 spit 
           ON poshist.spaceman_item_sid = spit.spaceman_item_sid
           INNER JOIN P_LEW_CORE_AC.v_item_spaceman_item_1 itspit 
           ON spit.spaceman_item_sid = itspit.spaceman_item_sid
           INNER JOIN P_LEW_MART_LEAD_AC.v_itm_item_1 item_1
           ON itspit.item_sid = item.item_id 
           INNER JOIN P_LEW_CORE_AC.v_item_hist_1 itemhist 
           ON item.item_id = itemhist.item_sid
     WHERE poshist.dwh_valid_to = '9999-12-30' 
           AND itemhist.dwh_valid_to = '9999-12-30' 
           AND poshist.deleted_fg = 0
           AND itemhist.deleted_fg = 0
           AND spit.active_to_dt = '9999-12-30'
           AND item.subitemgroup_id >= 0
     ORDER BY sec.spaceman_section_sid ASC,item.subitemgroup_id ASC
     )
GROUP BY spaceman_section_sid;