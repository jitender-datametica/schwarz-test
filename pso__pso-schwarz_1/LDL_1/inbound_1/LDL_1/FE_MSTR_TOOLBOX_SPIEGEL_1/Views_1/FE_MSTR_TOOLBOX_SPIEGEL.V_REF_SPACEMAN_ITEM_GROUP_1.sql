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
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_SPACEMAN_ITEM_GROUP_1
(
     spaceman_item_grp_sid
    ,spaceman_item_grp_name
)
AS
SELECT itemgr.spaceman_item_grp_sid
     , itemgr.spaceman_item_grp_name
FROM   P_LEW_CORE_AC.v_ref_spaceman_item_group_1 itemgr;