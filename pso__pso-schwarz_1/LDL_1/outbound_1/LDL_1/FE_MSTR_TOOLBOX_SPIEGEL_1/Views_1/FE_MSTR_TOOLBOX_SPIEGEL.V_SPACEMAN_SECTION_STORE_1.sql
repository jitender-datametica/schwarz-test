/*
#----------------------------------------------------------------------------
# Description:
# This view provides the combination of stores and their dedicated sections.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_store_1 (client_id, spaceman_section_sid,
loc_sid_store) AS SELECT client_id,
 spaceman_section_sid,
 loc_sid_store
FROM ldl_p_lew_core_ac.v_spaceman_section_store_hist_1 AS STOREHIST
WHERE dwh_valid_to = DATE '9999-12-30'
 AND deleted_fg = 0;