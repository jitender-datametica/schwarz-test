/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup of group level 2 and their connection to group level 1.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_SECTION_GROUP_LEVEL_2
(
    section_group_level_2_nr
    ,section_group_level_2_name
    ,section_group_level_1_nr
    ,int_org_sid
)
AS
SELECT lvl.section_group_level_2_nr
     , lvl.section_group_level_2_name
     , lvl.section_group_level_1_nr
     , lvl.int_org_sid
FROM   P_LEW_CORE_AC.v_spaceman_section_group_level_2_hist lvl
WHERE  lvl.dwh_valid_to = '9999-12-30' 
   AND lvl.deleted_fg = 0;
       