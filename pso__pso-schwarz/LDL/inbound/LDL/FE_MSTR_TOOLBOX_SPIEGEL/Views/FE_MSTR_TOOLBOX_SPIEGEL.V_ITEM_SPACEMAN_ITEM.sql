/*
#----------------------------------------------------------------------------
# Description:
# This view provides the matching of item and spaceman item.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_ITEM_SPACEMAN_ITEM
(
    item_sid
    , spaceman_item_sid
    , client_id
)
AS
SELECT itspit.item_sid
     , itspit.spaceman_item_sid
     , itemhist.client_id
FROM   P_LEW_CORE_AC.v_item_spaceman_item itspit 
 INNER JOIN P_LEW_CORE_AC.v_item_hist itemhist
    ON itspit.item_sid = itemhist.item_sid
WHERE  itemhist.deleted_fg = 0 
   AND itemhist.dwh_valid_to = '9999-12-30';
