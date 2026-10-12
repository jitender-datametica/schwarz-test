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

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_SPACEMAN_SECTION_SUBITEMGROUP_LIST_2
(
    spaceman_section_sid
    ,subitemgroup_list
)
AS 
SELECT spaceman_section_sid
     , subitemgroup_list
FROM FE_MSTR_TOOLBOX_SPIEGEL.t_agg_spaceman_section_subitemgroup_list_2;