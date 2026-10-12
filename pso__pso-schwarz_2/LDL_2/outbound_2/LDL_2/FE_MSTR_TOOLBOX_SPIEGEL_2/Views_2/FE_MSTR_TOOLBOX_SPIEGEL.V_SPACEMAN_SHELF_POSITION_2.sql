/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup for positions of section/shelf
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_shelf_position_2 (shelf_sid, src_section_nr, src_shelf_nr,
src_position_nr, shelf_position_sid, spaceman_item_sid, item_merchandising_type_cd, case_orientation_cd, x_case_cnt,
z_case_cnt, total_piece_qty, total_case_qty, position_width_meas) AS SELECT POS.shelf_sid,
 POS.src_section_nr,
 POS.src_shelf_nr,
 POS.src_position_nr,
 POSHIST.shelf_position_sid,
 POSHIST.spaceman_item_sid,
 POSHIST.item_merchandising_type_cd,
 POSHIST.case_orientation_cd,
 POSHIST.x_case_cnt,
 POSHIST.z_case_cnt,
 POSHIST.total_piece_qty,
 POSHIST.total_case_qty,
 POSHIST.position_width_meas
FROM ldl_p_lew_core_ac.v_spaceman_shelf_position_2 AS POS
 INNER JOIN ldl_p_lew_core_ac.v_spaceman_shelf_position_hist_2 AS POSHIST ON POS.shelf_position_sid = POSHIST.shelf_position_sid
  
WHERE POSHIST.dwh_valid_to = DATE '9999-12-30'
 AND POSHIST.deleted_fg = 0;