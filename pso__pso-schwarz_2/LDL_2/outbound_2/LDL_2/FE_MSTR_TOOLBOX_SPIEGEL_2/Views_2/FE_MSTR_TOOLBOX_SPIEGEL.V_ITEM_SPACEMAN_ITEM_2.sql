/*
#----------------------------------------------------------------------------
# Description:
# This view provides the matching of item_2 and spaceman item.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_item_spaceman_item_2 (item_sid, spaceman_item_sid, client_id) AS
SELECT ITSPIT.item_sid,
 ITSPIT.spaceman_item_sid,
 ITEMHIST.client_id
FROM ldl_p_lew_core_ac.v_item_spaceman_item_2 AS ITSPIT
 INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS ITEMHIST ON ITSPIT.item_sid = ITEMHIST.item_sid
WHERE ITEMHIST.deleted_fg = 0
 AND ITEMHIST.dwh_valid_to = DATE '9999-12-30';