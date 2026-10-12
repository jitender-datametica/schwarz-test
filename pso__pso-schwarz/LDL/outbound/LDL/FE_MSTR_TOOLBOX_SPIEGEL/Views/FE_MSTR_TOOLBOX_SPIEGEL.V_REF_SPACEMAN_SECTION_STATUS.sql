/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup of spaceman section status.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_ref_spaceman_section_status (section_status_cd, section_status_name
, section_status_descr) AS SELECT section_status_cd,
 section_status_name,
 section_status_descr
FROM ldl_p_lew_core_ac.v_ref_spaceman_section_status AS SECSTAT;