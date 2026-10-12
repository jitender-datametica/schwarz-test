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

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_SECTION_SHELF
(
    spaceman_section_sid
    ,src_section_nr
    ,src_shelf_nr
    ,shelf_sid
    ,shelf_width_meas
    ,shelf_depth_meas
    ,shelf_thickness_meas
    ,shelf_start_high_meas
    ,shelf_start_width_meas
)
AS
SELECT shelf.spaceman_section_sid
     , CAST(TO_NUMBER(shelf.src_section_nr) AS INTEGER) AS src_section_nr 
     , shelf.src_shelf_nr
     , shelfhist.shelf_sid
     , shelfhist.shelf_width_meas
     , shelfhist.shelf_depth_meas
     , shelfhist.shelf_thickness_meas
     , shelfhist.shelf_start_high_meas
     , shelfhist.shelf_start_width_meas
FROM   P_LEW_CORE_AC.v_spaceman_section_shelf shelf 
 INNER JOIN P_LEW_CORE_AC.v_spaceman_section_shelf_hist shelfhist 
    ON shelf.shelf_sid = shelfhist.shelf_sid
WHERE  shelfhist.dwh_valid_to = '9999-12-30' 
   AND shelfhist.deleted_fg = 0;
