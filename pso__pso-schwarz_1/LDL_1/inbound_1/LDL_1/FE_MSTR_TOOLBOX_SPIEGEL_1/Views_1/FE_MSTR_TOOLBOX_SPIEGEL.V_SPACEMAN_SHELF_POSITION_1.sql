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

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_SHELF_POSITION_1
(
    shelf_sid
    ,src_section_nr
    ,src_shelf_nr
    ,src_position_nr
    ,shelf_position_sid
    ,spaceman_item_sid
    ,item_merchandising_type_cd
    ,case_orientation_cd
    ,x_case_cnt
    ,z_case_cnt
    ,total_piece_qty
    ,total_case_qty
    ,position_width_meas
)
AS
SELECT pos.shelf_sid
     , pos.src_section_nr
     , pos.src_shelf_nr
     , pos.src_position_nr
     , poshist.shelf_position_sid
     , poshist.spaceman_item_sid
     , poshist.item_merchandising_type_cd
     , poshist.case_orientation_cd
     , poshist.x_case_cnt
     , poshist.z_case_cnt
     , poshist.total_piece_qty
     , poshist.total_case_qty
     , poshist.position_width_meas
FROM   P_LEW_CORE_AC.v_spaceman_shelf_position_1 pos 
 INNER JOIN P_LEW_CORE_AC.v_spaceman_shelf_position_hist_1 poshist 
    ON pos.shelf_position_sid = poshist.shelf_position_sid
WHERE  poshist.dwh_valid_to = '9999-12-30' 
   AND poshist.deleted_fg = 0;