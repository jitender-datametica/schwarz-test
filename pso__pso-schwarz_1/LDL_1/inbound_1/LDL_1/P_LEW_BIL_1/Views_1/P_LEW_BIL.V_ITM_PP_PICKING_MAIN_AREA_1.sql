create or replace view LDL_PRODUCTION.P_LEW_BIL.V_ITM_PP_PICKING_MAIN_AREA_1(
	CLIENT_ID,
	WH_ID_PP,
	PICKING_AREA_NR_PP,
	PICKING_MAIN_AREA_NR_PP,
	PICKING_MAIN_AREA_DESC_PP
) as
   SELECT
   client_id,
   loc_sid AS wh_id_pp               
   ,
   pick_area_id AS picking_area_nr_pp,
   pick_main_area_id AS picking_main_area_nr_pp,
   pick_main_area_descr AS picking_main_area_desc_pp
   FROM p_lew_core_ac.v_ref_pick_area_descr_1
  
  WHERE lang_sid = 2
;
