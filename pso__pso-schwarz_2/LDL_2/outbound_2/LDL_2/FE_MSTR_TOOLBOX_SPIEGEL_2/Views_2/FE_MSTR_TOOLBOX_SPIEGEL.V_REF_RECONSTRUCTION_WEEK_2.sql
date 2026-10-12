/*
#----------------------------------------------------------------------------
# Description:
# Static view for Reporting.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     27.11.2023      Aparna Rayanki          Initial Version
#  2.0     27.02.2024      Simeon Nikolaev         Added COMPENSATION_WEEK_FG
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_ref_reconstruction_week_2 (storage_test_exec_sid, orig_store_nr,
test_week, reconstruction_week_fg, excluded_week_fg, compensation_week_fg) AS SELECT storage_test_exec_sid,
 orig_store_nr,
 test_week,
 reconstruction_week_fg,
 excluded_week_fg,
 compensation_week_fg
FROM ldl_fe_mstr_toolbox_spiegel.t_ref_reconstruction_week_2;