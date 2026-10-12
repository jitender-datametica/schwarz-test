/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup of case orientation.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_ref_spaceman_case_orientation_2 (case_orientation_cd,
case_orientation_descr) AS SELECT case_orientation_cd,
 case_orientation_descr
FROM ldl_p_lew_core_ac.v_ref_spaceman_case_orientation_2 AS CO;