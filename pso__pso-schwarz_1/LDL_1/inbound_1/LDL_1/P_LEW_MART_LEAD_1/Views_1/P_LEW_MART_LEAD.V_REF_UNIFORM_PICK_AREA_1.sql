/*
 * Standard mapping of picking area
 */
CREATE OR REPLACE VIEW p_lew_mart_lead.v_ref_uniform_pick_area_1(
	PICK_AREA_NR
   ,PICK_AREA_DESCR
   ,PICK_MAIN_AREA_NR
) 
AS
	SELECT 
	    pick_area_nr
	   ,pick_area_descr
	   ,pick_main_area_nr
FROM p_lew_core_ac.v_ref_uniform_pick_area_1;