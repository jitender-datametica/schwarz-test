/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup for shelfes.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_section_shelf_2 (spaceman_section_sid, src_section_nr,
src_shelf_nr, shelf_sid, shelf_width_meas, shelf_depth_meas, shelf_thickness_meas, shelf_start_high_meas,
shelf_start_width_meas) AS SELECT SHELF.spaceman_section_sid,
 CAST(ROUND(CAST(SHELF.src_section_nr AS BIGNUMERIC), 0) AS BIGNUMERIC) AS src_section_nr,
 SHELF.src_shelf_nr,
 SHELFHIST.shelf_sid,
 SHELFHIST.shelf_width_meas,
 SHELFHIST.shelf_depth_meas,
 SHELFHIST.shelf_thickness_meas,
 SHELFHIST.shelf_start_high_meas,
 SHELFHIST.shelf_start_width_meas
FROM ldl_p_lew_core_ac.v_spaceman_section_shelf_2 AS SHELF
 INNER JOIN ldl_p_lew_core_ac.v_spaceman_section_shelf_hist_2 AS SHELFHIST ON SHELF.shelf_sid = SHELFHIST.shelf_sid
WHERE SHELFHIST.dwh_valid_to = DATE '9999-12-30'
 AND SHELFHIST.deleted_fg = 0;