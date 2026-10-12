/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup of spaceman item segment.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_SPACEMAN_ITEM_SEGMENT
(
    spaceman_item_segment_sid
    ,spaceman_item_segment_name
)
AS
SELECT itemseg.spaceman_item_segment_sid
     , itemseg.spaceman_item_segment_name
FROM   P_LEW_CORE_AC.v_ref_spaceman_item_segment itemseg;
