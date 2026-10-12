/*
#----------------------------------------------------------------------------
# Description:
# # This view provides the lookup of group level 5 and their connection to group level 4.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_SECTION_GROUP_LEVEL_5_1
(
    section_group_level_5_nr
    ,section_group_level_5_name
    ,section_group_level_4_nr
    ,int_org_sid
)
AS
SELECT lvl.section_group_level_5_nr
     , lvl.section_group_level_5_name
     , lvl.section_group_level_4_nr
     , lvl.int_org_sid
FROM   P_LEW_CORE_AC.v_spaceman_section_group_level_5_hist_1 lvl
WHERE  lvl.dwh_valid_to = '9999-12-30' 
   AND lvl.deleted_fg = 0;